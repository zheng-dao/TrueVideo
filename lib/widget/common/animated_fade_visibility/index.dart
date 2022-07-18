import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomAnimatedFadeVisibility extends HookConsumerWidget {
  final bool visible;
  final Widget? child;
  final double minOpacity;
  final Duration duration;
  final Curve curve;

  const CustomAnimatedFadeVisibility({
    Key? key,
    this.visible = true,
    this.child,
    this.minOpacity = 0.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : minOpacity,
        duration: duration,
        curve: curve,
        child: child ?? Container(),
      ),
    );
  }
}
