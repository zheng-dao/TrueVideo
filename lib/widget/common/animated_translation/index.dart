import 'package:flutter/material.dart';

class CustomAnimatedTranslation extends StatefulWidget {
  final Offset translation;
  final Widget child;
  final Duration duration;
  final Curve? curve;

  const CustomAnimatedTranslation({
    Key? key,
    this.translation = Offset.zero,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve,
  }) : super(key: key);

  @override
  State<CustomAnimatedTranslation> createState() => _CustomAnimatedTranslationState();
}

class _CustomAnimatedTranslationState extends State<CustomAnimatedTranslation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _translation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _translation = Tween<Offset>(begin: widget.translation, end: widget.translation).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedTranslation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.translation != widget.translation || oldWidget.duration != widget.duration || oldWidget.curve != widget.curve) {
      _animate();
    }
  }

  _animate() {
    _animationController.stop();
    _animationController.duration = widget.duration;

    _translation = Tween<Offset>(
      begin: _translation.value,
      end: widget.translation,
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
        return Transform.translate(
          offset: _translation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
