import 'package:flutter/material.dart';

class CustomAnimatedScale extends StatefulWidget {
  final double scale;
  final Widget child;
  final Duration duration;
  final Curve? curve;
  final Alignment alignment;

  const CustomAnimatedScale({
    Key? key,
    this.scale = 1.0,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<CustomAnimatedScale> createState() => _CustomAnimatedScaleState();
}

class _CustomAnimatedScaleState extends State<CustomAnimatedScale> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _scale = Tween<double>(begin: widget.scale, end: widget.scale).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scale != widget.scale || oldWidget.duration != widget.duration || oldWidget.curve != widget.curve) {
      _animate();
    }
  }

  _animate() {
    _animationController.stop();
    _animationController.duration = widget.duration;

    _scale = Tween<double>(
      begin: _scale.value,
      end: widget.scale,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve ?? Curves.easeInOut,
      ),
    );

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          alignment: widget.alignment,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
