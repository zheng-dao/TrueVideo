import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:truvideo_enterprise/core/video.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

import 'dim.dart';
import 'handler.dart';

const _handlerWidth = 40.0;
const _handlerIndicatorWidth = 5.0;

class CustomVideoThumbnails extends StatefulHookWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String videoPath;
  final double contentBorderRadius;
  final double borderRadius;
  final int count;
  final Function()? onLeftHandlerDragStart;
  final Function(Duration duration)? onLeftHandlerDragEnd;
  final Function()? onRightHandlerDragStart;
  final Function(Duration duration)? onRightHandlerDragEnd;
  final bool enabled;
  final Duration? initialStart;
  final Duration? initialEnd;
  final ValueNotifier<Duration> position;
  final Function()? onCurrentPositionDragStart;
  final Function(Duration duration)? onCurrentPositionDragEnd;
  final Widget Function()? overlayBuilder;
  final Widget Function({
    required bool draggingHandler,
    required bool draggingCurrent,
    required Duration current,
    required Duration start,
    required Duration end,
    required double startPosition,
    required double endPosition,
    required double currentPosition,
  })? infoBuilder;
  final Function(Duration duration, double val)? onPressed;
  final Color? backgroundColor;
  final double height;

  const CustomVideoThumbnails({
    Key? key,
    this.margin,
    this.borderRadius = 0,
    this.backgroundColor,
    this.height = 35,
    this.initialStart,
    this.initialEnd,
    this.padding,
    required this.videoPath,
    this.contentBorderRadius = 3,
    this.count = 10,
    this.onLeftHandlerDragEnd,
    this.onRightHandlerDragEnd,
    this.enabled = true,
    required this.position,
    this.onCurrentPositionDragStart,
    this.onCurrentPositionDragEnd,
    this.onLeftHandlerDragStart,
    this.onRightHandlerDragStart,
    this.overlayBuilder,
    this.infoBuilder,
    this.onPressed,
  }) : super(key: key);

  @override
  State<CustomVideoThumbnails> createState() => CustomVideoEditorThumbnailsState();
}

class CustomVideoEditorThumbnailsState extends State<CustomVideoThumbnails> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _left;
  late Animation<double> _right;
  final _dragging = ValueNotifier(false);
  final _draggingCurrent = ValueNotifier(false);
  final _currentPosition = ValueNotifier<Duration?>(null);
  Duration _videoDuration = Duration.zero;
  double _lastLeftPercentage = 0.0;
  double _lastRightPercentage = 1.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _left = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _right = Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  _animate({
    double? left,
    double? right,
    Duration? duration,
  }) async {
    _left = Tween<double>(
      begin: _left.value,
      end: left ?? _left.value,
    ).animate(_animationController);

    _right = Tween<double>(
      begin: _right.value,
      end: right ?? _right.value,
    ).animate(_animationController);

    final newDuration = duration ?? Duration.zero;
    if (newDuration == Duration.zero) {
      _animationController.value = 1.0;
    } else {
      _animationController.reset();
      _animationController.duration = newDuration;
      await _animationController.forward();
    }
  }

  reset() {
    _animate(
      left: 0.0,
      right: 1.0,
      duration: const Duration(milliseconds: 300),
    );

    widget.onLeftHandlerDragEnd?.call(Duration.zero);
    widget.onRightHandlerDragEnd?.call(_videoDuration);
  }

  _onVideoDuration(Duration duration) async {
    _videoDuration = duration;

    if (widget.initialStart != null) {
      final p = widget.initialStart!.inMilliseconds / _videoDuration.inMilliseconds;
      // _currentPosition.value = widget.initialStart!;
      _animate(left: p);
    }

    if (widget.initialEnd != null) {
      final p = widget.initialEnd!.inMilliseconds / _videoDuration.inMilliseconds;
      _animate(right: p);
    }

    await CustomWidgetUtils.wait();
    if (widget.initialStart != null) {
      widget.onLeftHandlerDragEnd?.call(widget.initialStart!);
    }
  }

  double get _leftMargin {
    final m = widget.padding ?? EdgeInsets.zero;
    return m.left;
  }

  double get _rightMargin {
    final m = widget.padding ?? EdgeInsets.zero;
    return m.right;
  }

  double get _horizontalMargin {
    final m = widget.padding ?? EdgeInsets.zero;
    return m.left + m.right;
  }

  Duration _toDuration(double x) {
    return Duration(milliseconds: (x * _videoDuration.inMilliseconds).floor());
  }

  _secondsToWidth(double maxWidth, double seconds) {
    final wPerSecond = maxWidth / _videoDuration.inSeconds;
    return wPerSecond * seconds;
  }

  _onLeftHandlerDragStart() {
    _dragging.value = true;
    widget.onLeftHandlerDragStart?.call();
  }

  _onLeftHandlerDragUpdate(double maxWidth, double x) {
    final w = maxWidth - _horizontalMargin;
    const minL = 0.0;
    final rPos = _right.value * w;
    final maxR = ((rPos - _secondsToWidth(maxWidth, 1.0)) / w).clamp(0.0, 1.0);

    var p = x / w;
    p += _left.value;
    p = p.clamp(minL, maxR);
    p = p.clamp(0.0, 1.0);
    _animate(left: p);

    _lastLeftPercentage = p;
    _currentPosition.value = _toDuration(p);
  }

  _onLeftHandlerDragEnd() {
    widget.onLeftHandlerDragEnd?.call(_toDuration(_lastLeftPercentage));
    _dragging.value = false;
    _currentPosition.value = null;
  }

  _onRightHandlerDragStart() {
    _dragging.value = true;
    widget.onRightHandlerDragStart?.call();
  }

  _onRightHandlerDragUpdate(double maxWidth, double x) {
    final w = maxWidth - _horizontalMargin;
    final lPos = _left.value * w;
    final minL = ((lPos + _secondsToWidth(maxWidth, 1.0)) / w).clamp(0.0, 1.0);
    const maxR = 1.0;
    var p = x / w;
    p += _right.value;
    p = p.clamp(minL, maxR);
    p = p.clamp(0.0, 1.0);
    _animate(right: p);
    _lastRightPercentage = p;
    _currentPosition.value = _toDuration(p);
  }

  _onRightHandlerDragEnd() {
    widget.onRightHandlerDragEnd?.call(_toDuration(_lastRightPercentage));
    _dragging.value = false;
    _currentPosition.value = null;
  }

  _onCurrentHandlerDragStart() {
    _draggingCurrent.value = true;
    widget.onCurrentPositionDragStart?.call();
  }

  _onCurrentHandlerDragUpdate(double maxWidth, double x) {
    final w = maxWidth - _horizontalMargin;
    final lPos = _left.value * w;
    final minL = lPos / w;
    final rPos = _right.value * w;
    final maxR = rPos / w;
    var p = x / w;
    p += (_currentPosition.value ?? widget.position.value).inMilliseconds / _videoDuration.inMilliseconds;
    p = p.clamp(minL, maxR);
    p = p.clamp(0.0, 1.0);

    _currentPosition.value = _toDuration(p);
  }

  _onCurrentHandlerDragEnd() {
    final v = _currentPosition.value ?? Duration.zero;
    _currentPosition.value = null;
    _draggingCurrent.value = false;
    widget.onCurrentPositionDragEnd?.call(v);
  }

  _onTap(double maxWidth, double x) {
    _currentPosition.value = null;
    final l = x + _left.value * (maxWidth - _horizontalMargin);
    final p = l / (maxWidth - _horizontalMargin);
    widget.onPressed?.call(_toDuration(p), p);
  }

  @override
  Widget build(BuildContext context) {
    final stream = useStream<List<Uint8List?>>(
      useMemoized(
        () {
          if (widget.videoPath.trim().isEmpty) return const Stream<List<Uint8List>>.empty();
          return CustomVideoUtils.streamThumbnails(
            filePath: widget.videoPath,
            numberOfThumbnails: widget.count,
            onVideoDuration: _onVideoDuration,
          );
        },
        [widget.videoPath, widget.count],
      ),
      initialData: <Uint8List>[],
    );

    final images = <Widget>[];
    for (int i = 0; i < widget.count; i++) {
      final data = stream.data ?? [];

      images.add(
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.shade900,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: i < data.length
                ? SizedBox(
                    key: ValueKey("image_$i"),
                    width: double.infinity,
                    height: double.infinity,
                    child: data[i] != null
                        ? Image(
                            image: MemoryImage(data[i]!),
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  )
                : Container(
                    key: ValueKey("empty_$i"),
                    color: Colors.grey.shade900,
                    width: double.infinity,
                    height: double.infinity,
                    child: Icon(
                      Icons.image,
                      color: Colors.white.withOpacity(0.3),
                      size: 12,
                    ),
                  ),
          ),
        ),
      );
    }

    return Container(
      margin: widget.margin,
      width: double.infinity,
      clipBehavior: Clip.none,
      child: LayoutBuilder(
        builder: (context, c) {
          final imgWidth = (c.maxWidth - _horizontalMargin) / widget.count;

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: widget.height,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        height: widget.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: widget.backgroundColor,
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                        ),
                      ),
                    ),

                    Container(
                      height: widget.height,
                      margin: widget.padding,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.contentBorderRadius),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          ...images
                              .map((e) => SizedBox(
                                    width: imgWidth,
                                    height: widget.height,
                                    child: e,
                                  ))
                              .toList(),
                        ],
                      ),
                    ),

                    // Left dim
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Positioned(
                        left: _leftMargin,
                        width: _left.value * (c.maxWidth - _horizontalMargin),
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                      child: CustomAnimatedFadeVisibility(
                        visible: widget.enabled,
                        child: CustomThumbnailDim(
                          left: true,
                          borderRadius: widget.contentBorderRadius,
                        ),
                      ),
                    ),

                    // Center
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Positioned(
                        left: (_left.value * (c.maxWidth - _horizontalMargin)) + _leftMargin,
                        width: (_right.value - _left.value) * (c.maxWidth - _horizontalMargin),
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTapUp: (details) => _onTap(c.maxWidth, details.localPosition.dx),
                          child: Container(
                            color: Colors.transparent,
                            child: widget.overlayBuilder?.call() ?? Container(),
                          ),
                        ),
                      ),
                    ),

                    // Right dim
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Positioned(
                        left: _leftMargin + _right.value * (c.maxWidth - _horizontalMargin),
                        right: _rightMargin,
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                      child: CustomThumbnailDim(
                        left: false,
                        borderRadius: widget.contentBorderRadius,
                      ),
                    ),

                    // Current position
                    MultiValueListenableBuilder(
                      valueListenables: [widget.position, _currentPosition],
                      builder: (context, values, child) {
                        double x = 0.0;
                        final d = _videoDuration.inMilliseconds;
                        if (d != 0) {
                          if (_currentPosition.value != null) {
                            x = _currentPosition.value!.inMilliseconds / d;
                          } else {
                            x = widget.position.value.inMilliseconds / d;
                          }
                        }

                        return Positioned(
                          left: _leftMargin + (x * (c.maxWidth - _horizontalMargin)),
                          top: 0,
                          bottom: 0,
                          child: child!,
                        );
                      },
                      child: Transform.translate(
                        offset: const Offset(-_handlerWidth / 2, 0),
                        child: CustomThumbnailHandler(
                          width: _handlerWidth,
                          indicatorWidth: _handlerIndicatorWidth,
                          height: widget.height,
                          enabled: widget.enabled,
                          color: Colors.white,
                          dotColor: Colors.black.withOpacity(0.4),
                          onDragStart: _onCurrentHandlerDragStart,
                          onDragUpdate: (x) => _onCurrentHandlerDragUpdate(c.maxWidth, x),
                          onDragEnd: _onCurrentHandlerDragEnd,
                        ),
                      ),
                    ),

                    // Left trimmer
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Positioned(
                        left: (_left.value * (c.maxWidth - _horizontalMargin)) + _leftMargin,
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                      child: Transform.translate(
                        offset: const Offset(-_handlerWidth * 0.5, 0.0),
                        child: CustomThumbnailHandler(
                          enabled: widget.enabled,
                          width: _handlerWidth,
                          height: widget.height,
                          indicatorWidth: _handlerIndicatorWidth,
                          onDragStart: _onLeftHandlerDragStart,
                          onDragUpdate: (x) => _onLeftHandlerDragUpdate(c.maxWidth, x),
                          onDragEnd: _onLeftHandlerDragEnd,
                        ),
                      ),
                    ),

                    // Right trimmer
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Positioned(
                        left: (_right.value * (c.maxWidth - _horizontalMargin)) + _leftMargin,
                        top: 0,
                        bottom: 0,
                        child: child!,
                      ),
                      child: Transform.translate(
                        offset: const Offset(-_handlerWidth * 0.5, 0.0),
                        child: CustomThumbnailHandler(
                          enabled: widget.enabled,
                          width: _handlerWidth,
                          height: widget.height,
                          indicatorWidth: _handlerIndicatorWidth,
                          onDragStart: _onRightHandlerDragStart,
                          onDragUpdate: (x) => _onRightHandlerDragUpdate(c.maxWidth, x),
                          onDragEnd: _onRightHandlerDragEnd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                // margin: widget.padding,
                clipBehavior: Clip.none,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => MultiValueListenableBuilder(
                    valueListenables: [_dragging, _draggingCurrent, _currentPosition, widget.position],
                    builder: (context, values, child) {
                      if (widget.infoBuilder == null) return Container();
                      final duration = _videoDuration;

                      final current = _currentPosition.value ?? widget.position.value;
                      final currentP = current.inMilliseconds / duration.inMilliseconds;

                      final startPosition = (_left.value * (c.maxWidth - _horizontalMargin)) + _leftMargin;
                      final endPosition = (_right.value * (c.maxWidth - _horizontalMargin)) + _leftMargin;
                      final currentPosition = _leftMargin + (currentP * (c.maxWidth - _horizontalMargin));

                      return widget.infoBuilder!(
                        draggingHandler: _dragging.value,
                        draggingCurrent: _draggingCurrent.value,
                        current: current,
                        start: _toDuration(_left.value),
                        end: _toDuration(_right.value),
                        startPosition: startPosition,
                        endPosition: endPosition,
                        currentPosition: currentPosition,
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
