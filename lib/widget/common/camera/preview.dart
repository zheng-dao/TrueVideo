import 'package:camera/camera.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:truvideo_enterprise/widget/common/animated_scale_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';

import 'focus.dart';

class CustomCameraPreview extends StatefulWidget {
  final CameraController? controller;
  final Function(Offset position)? onTap;
  final Function(double zoom)? changeZoom;
  final double minZoom;
  final double maxZoom;
  final ValueNotifier<double> zoom;
  final bool visible;
  final bool fullScreen;

  final bool recording;
  final bool recordingPaused;

  const CustomCameraPreview({
    Key? key,
    this.controller,
    this.onTap,
    this.minZoom = 0.0,
    this.maxZoom = 0.0,
    this.changeZoom,
    required this.zoom,
    this.visible = true,
    this.fullScreen = true,
    this.recording = false,
    this.recordingPaused = false,
  }) : super(key: key);

  @override
  State<CustomCameraPreview> createState() => _CustomCameraPreviewState();
}

class _CustomCameraPreviewState extends State<CustomCameraPreview> {
  int _pointers = 0;
  double _baseZoom = 1.0;
  final _focusPosition = ValueNotifier<Offset?>(null);
  final _focusPositionVisible = ValueNotifier<bool>(false);

  bool get _isReady {
    if (widget.controller == null) return false;
    if (!widget.controller!.value.isInitialized) return false;
    if (!widget.visible) return false;
    return true;
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseZoom = widget.zoom.value;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (!_isReady) return;
    if (widget.minZoom == 0.0 && widget.maxZoom == 0.0) return;

    if (_pointers != 2) return;

    final zoom = (_baseZoom * details.scale).clamp(widget.minZoom, widget.maxZoom);
    widget.changeZoom?.call(zoom);
  }

  void _onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (!_isReady) return;

    _focusPosition.value = details.localPosition;
    _focusPositionVisible.value = true;
    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );

    widget.onTap?.call(offset);

    EasyDebounce.debounce("visible", const Duration(milliseconds: 300), () {
      if (!mounted) return;
      _focusPositionVisible.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!_isReady) {
      child = const SizedBox(
        width: double.infinity,
        height: double.infinity,
        key: ValueKey("empty"),
      );
    } else {
      child = SizedBox(
        width: double.infinity,
        height: double.infinity,
        key: const ValueKey("camera"),
        child: LayoutBuilder(builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          var scale = size.aspectRatio * widget.controller!.value.aspectRatio;
          if (scale < 1) scale = 1 / scale;

          return Stack(
            children: [
              // Preview
              Positioned.fill(
                child: ClipRRect(
                  child: Center(
                    child: CustomAnimatedScale(
                      scale: widget.fullScreen ? scale : 1.0,
                      child: CameraPreview(
                        widget.controller!,
                        child: ClipRRect(
                          child: Listener(
                            onPointerDown: (_) => _pointers++,
                            onPointerUp: (_) => _pointers--,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Stack(
                                children: [
                                  MultiValueListenableBuilder(
                                    valueListenables: [_focusPosition, _focusPositionVisible],
                                    builder: (context, value, child) => Positioned(
                                      left: _focusPosition.value?.dx ?? 0,
                                      top: _focusPosition.value?.dy ?? 0,
                                      child: FractionalTranslation(
                                        translation: const Offset(-0.5, -0.5),
                                        child: CustomCameraFocus(
                                          visible: _focusPositionVisible.value,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onScaleStart: _handleScaleStart,
                                      onScaleUpdate: _handleScaleUpdate,
                                      onTapDown: (TapDownDetails details) => _onViewFinderTap(details, constraints),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: widget.recording && !widget.recordingPaused ? 1.0 : 0.0,
                    child: CustomPaint(
                      painter: _CornerPainter(
                        color: Colors.red,
                        strokeWidth: 10,
                        lineSize: 60,
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    }

    try {
      return CustomAnimatedSwitcher(child: child);
    } catch (error) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
      );
    }
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double lineSize;

  _CornerPainter({
    required this.color,
    this.strokeWidth = 10.0,
    this.lineSize = 50,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Top left
    canvas.drawRect(Rect.fromLTRB(0.0, 0.0, lineSize, strokeWidth), Paint()..color = color);
    canvas.drawRect(Rect.fromLTRB(0.0, 0.0, strokeWidth, lineSize), Paint()..color = color);

    // Top right
    canvas.drawRect(
      Rect.fromLTRB(
        size.width - lineSize,
        0.0,
        size.width,
        strokeWidth,
      ),
      Paint()..color = color,
    );
    canvas.drawRect(
      Rect.fromLTRB(
        size.width - strokeWidth,
        0.0,
        size.width,
        lineSize,
      ),
      Paint()..color = color,
    );

    // Bottom left
    canvas.drawRect(
      Rect.fromLTRB(
        0.0,
        size.height - strokeWidth,
        lineSize,
        size.height,
      ),
      Paint()..color = color,
    );
    canvas.drawRect(
      Rect.fromLTRB(
        0.0,
        size.height - lineSize,
        strokeWidth,
        size.height,
      ),
      Paint()..color = color,
    );

    // Bottom right
    canvas.drawRect(
      Rect.fromLTRB(
        size.width - lineSize,
        size.height - strokeWidth,
        size.width,
        size.height,
      ),
      Paint()..color = color,
    );
    canvas.drawRect(
      Rect.fromLTRB(
        size.width - strokeWidth,
        size.height - lineSize,
        size.width,
        size.height,
      ),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) {
    if (oldDelegate.color != color) return true;
    if (oldDelegate.strokeWidth != strokeWidth) return true;
    if (oldDelegate.lineSize != lineSize) return true;
    return true;
  }
}
