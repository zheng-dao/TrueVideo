import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';

class CustomRipple extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onLongPress;
  final Widget? child;
  final BorderRadius? borderRadius;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? color;

  const CustomRipple({
    Key? key,
    this.onPressed,
    this.onLongPress,
    this.child,
    this.borderRadius,
    this.hoverColor,
    this.splashColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      clipBehavior: Clip.hardEdge,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: color ?? Colors.transparent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: splashColor ?? CustomColorsUtils.rippleColor,
            focusColor: hoverColor ?? CustomColorsUtils.rippleColor,
            highlightColor: hoverColor ?? CustomColorsUtils.rippleColor,
            hoverColor: hoverColor ?? CustomColorsUtils.rippleColor,
            onTap: onPressed,
            onLongPress: onLongPress,
            child: child,
          ),
        ),
      ),
    );
  }
}
