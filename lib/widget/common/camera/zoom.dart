import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomCameraZoomIndicator extends StatelessWidget {
  final double minZoom;
  final double maxZoom;
  final ValueNotifier<double> zoom;
  final Function(double zoom)? onChange;
  final bool dragBarVisible;
  final Function(bool value)? onDragBarVisibleChange;
  final bool enabled;
  final double height;

  const CustomCameraZoomIndicator({
    Key? key,
    this.minZoom = 1.0,
    this.maxZoom = 1.0,
    required this.zoom,
    this.onChange,
    required this.dragBarVisible,
    this.onDragBarVisibleChange,
    this.enabled = true,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return GestureDetector(
            onTapDown: (details) {
              onDragBarVisibleChange?.call(true);
            },
            onTapUp: (details) {
              if (dragBarVisible) {
                final newZoom = _mapRange(
                  details.localPosition.dx,
                  inputStart: 0.0,
                  inputEnd: constraints.maxWidth,
                  outputStart: minZoom,
                  outputEnd: maxZoom,
                );
                onChange?.call(newZoom);
              }

              onDragBarVisibleChange?.call(false);
            },
            onHorizontalDragStart: (details) {
              onDragBarVisibleChange?.call(true);
            },
            onHorizontalDragUpdate: (details) {
              final delta = _mapRange(
                details.delta.dx,
                inputStart: 0.0,
                inputEnd: constraints.maxWidth,
                outputStart: 0.0,
                outputEnd: 1.0,
              );

              var newZoomPercentage = _mapRange(
                    zoom.value,
                    inputStart: minZoom,
                    inputEnd: maxZoom,
                    outputStart: 0.0,
                    outputEnd: 1.0,
                  ) +
                  delta;
              newZoomPercentage = newZoomPercentage.clamp(0.0, 1.0);

              final newZoom = _mapRange(
                newZoomPercentage,
                inputStart: 0.0,
                inputEnd: 1.0,
                outputStart: minZoom,
                outputEnd: maxZoom,
              );

              onChange?.call(newZoom);
            },
            onHorizontalDragCancel: () {
              onDragBarVisibleChange?.call(false);
            },
            onHorizontalDragEnd: (details) {
              onDragBarVisibleChange?.call(false);
            },
            child: Stack(
              children: [
                // Button
                Positioned.fill(
                  child: CustomAnimatedFadeVisibility(
                    visible: !dragBarVisible,
                    child: Center(
                      child: ScaleTap(
                        onPressed: enabled ? () => onDragBarVisibleChange?.call(true) : null,
                        child: Container(
                          width: 40,
                          height: height,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: CustomColorsUtils.cameraButtonFillColor,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: CustomColorsUtils.cameraButtonBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: ValueListenableBuilder<double>(
                              valueListenable: zoom,
                              builder: (context, zoom, child) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    zoom.toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white, fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Bar
                Positioned.fill(
                  child: CustomAnimatedFadeVisibility(
                    visible: dragBarVisible,
                    child: Container(
                      height: height.clamp(0.0, 30),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 1,
                        ),
                      ),
                      child: ValueListenableBuilder<double>(
                        valueListenable: zoom,
                        builder: (context, zoom, child) => CustomPaint(
                          painter: _ZoomPainter(
                            value: zoom,
                            min: minZoom,
                            max: maxZoom,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ZoomPainter extends CustomPainter {
  final double min;
  final double max;
  final double value;
  double intervals = 0.25;

  _ZoomPainter({
    this.min = 1.0,
    this.max = 10.0,
    this.value = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintSelected = Paint();
    paintSelected.color = Colors.amber;
    paintSelected.strokeWidth = 4;

    final paintMain = Paint();
    paintMain.color = Colors.white;
    paintMain.strokeWidth = 2;

    final paintSecondary = Paint();
    paintSecondary.color = Colors.white.withOpacity(0.6);
    paintSecondary.strokeWidth = 2;

    for (double i = min; i <= max; i += intervals) {
      var p = _mapRange(i, inputStart: min, inputEnd: max, outputStart: 0.0, outputEnd: size.width);

      if (isInteger(i)) {
        canvas.drawLine(
          Offset(p, 2),
          Offset(p, size.height - 2),
          paintMain,
        );
      } else {
        canvas.drawLine(
          Offset(p, 4),
          Offset(p, size.height - 4),
          paintSecondary,
        );
      }
    }

    var p = _mapRange(value, inputStart: min, inputEnd: max, outputStart: 0.0, outputEnd: size.width);
    canvas.drawLine(
      Offset(p, 0),
      Offset(p, size.height),
      paintSelected,
    );
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  @override
  bool shouldRepaint(covariant _ZoomPainter oldDelegate) {
    return min != oldDelegate.min || max != oldDelegate.max || value != oldDelegate.value;
  }
}

double _mapRange(
  double input, {
  required double inputStart,
  required double inputEnd,
  required double outputStart,
  required double outputEnd,
}) {
  return outputStart + ((outputEnd - outputStart) / (inputEnd - inputStart)) * (input - inputStart);
}
