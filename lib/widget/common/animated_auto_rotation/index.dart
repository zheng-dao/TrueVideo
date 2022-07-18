import 'package:flutter/material.dart';

class CustomAnimatedAutoRotation extends StatefulWidget {
  final Widget child;
  final double upperBound;
  const CustomAnimatedAutoRotation({
    required this.child,
    this.upperBound = 0.50,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAnimatedAutoRotation> createState() => _CustomAnimatedAutoRotationState();
}


class _CustomAnimatedAutoRotationState extends State<CustomAnimatedAutoRotation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
    lowerBound: 0,
    upperBound: widget.upperBound,
  )
    ..repeat(
      reverse: true,
      period: const Duration(
        milliseconds: 700,
      ),
    );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    reverseCurve: Curves.easeOut,
    curve: Curves.easeIn,
  );

  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _controller.reverse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: turnsTween.animate(_animation),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
    );
  }
}
