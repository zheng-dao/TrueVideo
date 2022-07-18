import 'dart:math';

import 'package:flutter/material.dart';

class CustomAnimatedListItem extends AnimatedWidget {
  final Animation<double> animation;
  final Curve curve;
  final double sizeFraction;
  final Axis axis;
  final double axisAlignment;
  final Widget child;

  const CustomAnimatedListItem({
    Key? key,
    required this.animation,
    this.sizeFraction = 2 / 3,
    this.curve = Curves.linear,
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    required this.child,
  })  : assert(sizeFraction >= 0.0 && sizeFraction <= 1.0),
        super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final currentAnimation = listenable as Animation<double>;
    final currentCurve = CurvedAnimation(parent: currentAnimation, curve: curve);
    final currentSize = CurvedAnimation(curve: Interval(0.0, sizeFraction), parent: currentCurve);
    final currentOpacity = CurvedAnimation(curve: Interval(sizeFraction, 1.0), parent: currentCurve);

    return Align(
      alignment: Alignment.center,
      heightFactor: axis == Axis.vertical ? max(currentSize.value, 0.0) : null,
      widthFactor: axis == Axis.horizontal ? max(currentSize.value, 0.0) : null,
      child: Opacity(
        opacity: currentOpacity.value,
        child: child,
      ),
    );
  }
}
