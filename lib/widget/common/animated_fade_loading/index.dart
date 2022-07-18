import 'package:flutter/material.dart';

class CustomAnimatedLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Duration? duration;
  const CustomAnimatedLoadingWidget({
    required this.child,
    required this.loading,
    this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          duration: duration ?? const Duration(milliseconds: 300),
          opacity: loading ? 1.0 : 0.0,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        AnimatedOpacity(duration: duration ?? const Duration(milliseconds: 300), opacity: !loading ? 1.0 : 0.0, child: child),
      ],
    );
  }
}
