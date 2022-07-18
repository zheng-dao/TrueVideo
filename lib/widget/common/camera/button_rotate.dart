import 'dart:math';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/camera/button.dart';

class CustomCameraButtonRotate extends StatefulWidget {
  final Function()? onPressed;
  final bool enabled;
  final double size;

  const CustomCameraButtonRotate({
    Key? key,
    this.onPressed,
    this.enabled = true,
    required this.size,
  }) : super(key: key);

  @override
  State<CustomCameraButtonRotate> createState() => _CustomCameraButtonRotateState();
}

class _CustomCameraButtonRotateState extends State<CustomCameraButtonRotate> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _rotation = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _animate() async {
    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.reset();
    _animationController.duration = const Duration(milliseconds: 300);
    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Transform.rotate(
        angle: -_rotation.value * pi,
        child: child,
      ),
      child: CustomCameraButton(
        size: widget.size,
        enabled: widget.enabled,
        icon: Icons.flip_camera_android,
        onPressed: widget.onPressed != null
            ? () {
                _animate();
                widget.onPressed?.call();
              }
            : null,
      ),
    );
  }
}
