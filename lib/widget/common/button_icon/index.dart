import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/tooltip/index.dart';

class CustomButtonIcon extends HookConsumerWidget {
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double iconSize;
  final double? elevation;
  final double? focusedElevation;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final bool enabled;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;
  final bool circle;
  final double? size;
  final bool loading;
  final Widget? child;
  final String tooltip;
  final EdgeInsets? margin;

  const CustomButtonIcon({
    this.tooltip = "",
    this.margin,
    Key? key,
    this.child,
    this.loading = false,
    this.size,
    this.circle = true,
    this.iconColor,
    required this.icon,
    this.padding,
    this.backgroundColor,
    this.iconSize = 20,
    this.elevation,
    this.focusedElevation,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.enabled = true,
    this.autoFocus = false,
    this.focusNode,
    this.onPressed,
  }) : super(key: key);

  const CustomButtonIcon.small({
    this.tooltip = "",
    this.margin,
    Key? key,
    this.child,
    this.loading = false,
    this.size = 35,
    this.circle = true,
    this.iconColor,
    required this.icon,
    this.padding,
    this.backgroundColor,
    this.iconSize = 13,
    this.elevation,
    this.focusedElevation,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.enabled = true,
    this.autoFocus = false,
    this.focusNode,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = <MaterialState>{};

    // Elevation
    double currentElevation;
    if (elevation != null) {
      currentElevation = elevation!;
    } else {
      currentElevation = theme.elevatedButtonTheme.style?.elevation?.resolve(s) ?? 0.0;
    }

    double currentFocusElevation;
    if (focusedElevation != null) {
      currentFocusElevation = focusedElevation!;
    } else {
      currentFocusElevation = theme.elevatedButtonTheme.style?.elevation?.resolve({MaterialState.pressed}) ?? currentElevation;
    }

    // Colors
    Color currentBackgroundColor;
    if (backgroundColor != null) {
      currentBackgroundColor = backgroundColor!;
    } else {
      currentBackgroundColor = theme.elevatedButtonTheme.style?.backgroundColor?.resolve(s) ?? Colors.transparent;
    }

    Color currentIconColor = iconColor ?? currentBackgroundColor.contrast(context);

    // Shape
    RoundedRectangleBorder? currentState = theme.elevatedButtonTheme.style?.shape?.resolve(s) as RoundedRectangleBorder?;
    OutlinedBorder currentShape = circle
        ? CircleBorder(
            side: borderWidth != null && borderWidth! > 0
                ? BorderSide(
                    color: borderColor ?? currentState?.side.color ?? Colors.transparent,
                    width: borderWidth ?? currentState?.side.width ?? 0,
                  )
                : BorderSide.none,
          )
        : RoundedRectangleBorder(
            side: borderWidth != null && borderWidth! > 0
                ? BorderSide(
                    color: borderColor ?? currentState?.side.color ?? Colors.transparent,
                    width: borderWidth ?? currentState?.side.width ?? 0,
                  )
                : BorderSide.none,
          );

    // Fix
    if (currentBackgroundColor.opacity == 0 || currentBackgroundColor == Colors.transparent) {
      currentElevation = 0;
      currentFocusElevation = 0;
    }

    return Container(
      margin: margin,
      child: CustomAnimatedFadeVisibility(
        visible: enabled,
        minOpacity: 0.5,
        child: CustomTooltip(
          message: tooltip,
          child: RawMaterialButton(
            autofocus: autoFocus,
            focusNode: focusNode,
            onPressed: onPressed,
            fillColor: currentBackgroundColor,
            elevation: currentElevation,
            focusElevation: currentFocusElevation,
            disabledElevation: 0,
            hoverElevation: 0,
            highlightElevation: currentFocusElevation,
            shape: currentShape,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: size ?? 40.0,
              minHeight: size ?? 40.0,
              maxHeight: size ?? 40.0,
              maxWidth: size ?? 40.0,
            ),
            child: Stack(
              children: [
                Center(
                  child: CustomAnimatedFadeVisibility(
                    visible: !loading,
                    child: IconTheme(
                      data: IconThemeData(
                        size: iconSize,
                        color: currentIconColor,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: child ??
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                icon,
                                key: ValueKey(icon),
                                color: currentIconColor,
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CustomAnimatedFadeVisibility(
                    visible: loading,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: currentIconColor,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
