import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const CustomTooltip({
    Key? key,
    required this.child,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.trim().isEmpty) return child;
    return Tooltip(
      message: message,
      child: child,
    );
  }
}
