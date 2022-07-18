import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/widget.dart';

class CustomAnimatedCollapseVisibility extends StatefulWidget {
  final bool visible;
  final Axis axis;
  final Widget? child;
  final Duration duration;
  final Curve curve;
  final bool maintainState;

  const CustomAnimatedCollapseVisibility({
    Key? key,
    this.visible = true,
    this.axis = Axis.vertical,
    this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.maintainState = false,
  }) : super(key: key);

  @override
  State<CustomAnimatedCollapseVisibility> createState() => _CustomAnimatedCollapseVisibilityState();
}

class _CustomAnimatedCollapseVisibilityState extends State<CustomAnimatedCollapseVisibility> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<double> _size;
  final _render = ValueNotifier(false);

  @override
  void initState() {
    _render.value = widget.maintainState ? true : widget.visible;
    _animationController = AnimationController(vsync: this);
    _opacity = Tween<double>(
      begin: widget.visible ? 1 : 0,
      end: widget.visible ? 1 : 0,
    ).animate(_animationController);

    _size = Tween<double>(
      begin: widget.visible ? 1 : 0,
      end: widget.visible ? 1 : 0,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomAnimatedCollapseVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.visible != widget.visible) {
      _animate();
    }
  }

  Future<void> _animate() async {
    _animationController.stop();

    final newDuration = widget.duration;

    _opacity = Tween<double>(
      begin: _opacity.value,
      end: widget.visible ? 1 : 0,
    ).animate(CurvedAnimation(
      curve: Interval(
        widget.visible == true ? 0.5 : 0.0,
        widget.visible == true ? 1.0 : 0.5,
        curve: widget.curve,
      ),
      parent: _animationController,
    ));

    _size = Tween<double>(
      begin: _size.value,
      end: widget.visible ? 1 : 0,
    ).animate(CurvedAnimation(
      curve: Interval(
        widget.visible == true ? 0.0 : 0.5,
        widget.visible == true ? 0.5 : 1.0,
        curve: widget.curve,
      ),
      parent: _animationController,
    ));

    _animationController.reset();

    if (widget.visible) {
      _render.value = true;
      await CustomWidgetUtils.wait();
    }

    _animationController.duration = newDuration;
    await _animationController.forward();

    if (!widget.visible && !widget.maintainState) {
      _render.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child == null) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return ValueListenableBuilder<bool>(
      valueListenable: _render,
      builder: (context, value, child) {
        if (value == false) return const SizedBox(width: 0.0, height: 0.0);
        return child!;
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Align(
            alignment: Alignment.center,
            heightFactor: widget.axis == Axis.vertical ? math.max(_size.value, 0.0) : null,
            widthFactor: widget.axis == Axis.horizontal ? math.max(_size.value, 0.0) : null,
            child: Opacity(
              opacity: (_opacity.value).clamp(0.0, 1.0),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
