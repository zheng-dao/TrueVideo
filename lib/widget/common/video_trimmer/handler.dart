import 'package:flutter/material.dart';

import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_scale_visibility/index.dart';

class CustomThumbnailHandler extends StatefulWidget {
  final double height;
  final double width;
  final double indicatorWidth;
  final bool enabled;
  final Function()? onDragStart;
  final Function(double x)? onDragUpdate;
  final Function()? onDragEnd;
  final Color? color;
  final Color? dotColor;

  const CustomThumbnailHandler({
    Key? key,
    required this.height,
    required this.width,
    required this.indicatorWidth,
    this.enabled = true,
    this.onDragUpdate,
    this.color,
    this.onDragEnd,
    this.onDragStart,
    this.dotColor,
  }) : super(key: key);

  @override
  State<CustomThumbnailHandler> createState() => _CustomHandlerState();
}

class _CustomHandlerState extends State<CustomThumbnailHandler> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        if (!widget.enabled) return;

        widget.onDragStart?.call();
        if (widget.onDragUpdate != null) {
          setState(() => _focused = true);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (!widget.enabled) return;
        widget.onDragUpdate?.call(details.delta.dx);
      },
      onHorizontalDragEnd: (details) {
        if (!widget.enabled) return;
        widget.onDragEnd?.call();
        setState(() => _focused = false);
      },
      onHorizontalDragCancel: () {
        if (!widget.enabled) return;
        widget.onDragEnd?.call();
        setState(() => _focused = false);
      },
      child: CustomAnimatedScale(
        scale: _focused ? 1.4 : 1.2,
        child: CustomAnimatedFadeVisibility(
          visible: widget.enabled,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: widget.indicatorWidth,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.color ?? Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(widget.indicatorWidth),
                ),
                child: Center(
                  child: Container(
                    width: widget.indicatorWidth * 0.5,
                    height: widget.indicatorWidth * 0.5,
                    decoration: BoxDecoration(
                      color: widget.dotColor ?? Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
