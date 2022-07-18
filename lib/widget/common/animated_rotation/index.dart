import 'package:flutter/material.dart';

class CustomAnimatedRotation extends StatefulWidget {
  final double rotation;
  final Widget child;
  final Duration duration;
  final Curve? curve;
  final Alignment alignment;

  const CustomAnimatedRotation({
    Key? key,
    this.rotation = 1.0,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<CustomAnimatedRotation> createState() => _CustomAnimatedRotationState();
}

class _CustomAnimatedRotationState extends State<CustomAnimatedRotation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _rotation = Tween<double>(begin: widget.rotation, end: widget.rotation).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rotation != widget.rotation || oldWidget.duration != widget.duration || oldWidget.curve != widget.curve) {
      _animate();
    }
  }

  _animate() {
    _animationController.stop();
    _animationController.duration = widget.duration;

    _rotation = Tween<double>(
      begin: _rotation.value,
      end: widget.rotation,
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
        return Transform.rotate(
          angle: _rotation.value,
          alignment: widget.alignment,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
