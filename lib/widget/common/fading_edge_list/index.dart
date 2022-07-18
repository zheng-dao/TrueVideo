import 'package:flutter/material.dart';

class CustomFadingEdgeList extends StatelessWidget {
  final double size;
  final Axis direction;
  final Widget child;
  final Color color;

  const CustomFadingEdgeList({
    Key? key,
    this.size = 16.0,
    this.direction = Axis.vertical,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (direction == Axis.vertical)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        if (direction == Axis.vertical)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.0),
                    color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        if (direction == Axis.horizontal)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

        if (direction == Axis.horizontal)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.0),
                    color,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
