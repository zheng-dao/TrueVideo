import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomCameraFocus extends StatelessWidget {
  final bool visible;

  const CustomCameraFocus({
    Key? key,
    this.visible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: SizedBox(
        width: 70,
        height: 70,
        child: CustomPaint(
          painter: CustomCameraFocusPainter(),
        ),
      ),
    );
  }
}

class CustomCameraFocusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, 0.0),
      Offset(size.width * 0.5, size.height * 0.1),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.9),
      Offset(size.width * 0.5, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(0.0, size.height * 0.5),
      Offset(size.width * 0.1, size.height * 0.5),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.9, size.height * 0.5),
      Offset(size.width * 1.0, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
