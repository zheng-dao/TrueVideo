import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_loading.dart';

enum CustomContainerMode {
  loading,
  error,
  normal,
}

class CustomContainer extends StatelessWidget {
  final Widget Function(BuildContext context)? loadingBuilder;
  final dynamic errorData;
  final Widget Function(BuildContext context, dynamic error)? errorBuilder;
  final Widget Function(BuildContext context) builder;
  final Alignment alignment;
  final CustomContainerMode mode;

  const CustomContainer({
    Key? key,
    this.mode = CustomContainerMode.normal,
    this.loadingBuilder,
    this.errorData,
    this.errorBuilder,
    required this.builder,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (mode == CustomContainerMode.loading) {
      child = LayoutBuilder(
        key: const ValueKey("loading"),
        builder: (c, constraints) => Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          alignment: alignment,
          child: loadingBuilder?.call(context) ?? const CustomListIndicatorLoading(),
        ),
      );
    } else {
      if (mode == CustomContainerMode.error) {
        child = LayoutBuilder(
          key: const ValueKey("error"),
          builder: (c, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            alignment: alignment,
            child: errorBuilder?.call(context, errorData) ?? const CustomListIndicatorError(),
          ),
        );
      } else {
        child = LayoutBuilder(
          key: const ValueKey("content"),
          builder: (c, constraints) => SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: builder(context),
          ),
        );
      }
    }

    return CustomAnimatedSwitcher(child: child);
  }
}
