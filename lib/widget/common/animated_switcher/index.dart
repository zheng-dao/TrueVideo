import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final Widget? child;
  final Alignment alignment;

  const CustomAnimatedSwitcher({Key? key, this.child, this.alignment = Alignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      layoutBuilder: (current, previous) => Stack(
        alignment: alignment,
        children: [
          ...previous,
          if (current != null) current,
        ],
      ),
      child: child,
    );
  }
}
