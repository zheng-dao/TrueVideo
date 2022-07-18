import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomGradientButton extends HookConsumerWidget {
  final Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final bool autoFocus;
  final FocusNode? focusNode;
  final Color? foregroundColor;
  final bool enabled;
  final double? width;
  final EdgeInsets? margin;
  final IconData? icon;
  final double height;
  final bool loading;
  final bool uppercase;
  final LinearGradient gradient;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double elevation;
  final double textSize;
  final double iconSize;

  const CustomGradientButton({
    Key? key,
    this.textSize = 15,
    this.iconSize = 20,
    this.elevation = 0.0,
    this.borderRadius,
    this.padding,
    required this.gradient,
    this.uppercase = true,
    this.foregroundColor,
    this.height = 48,
    this.icon,
    this.margin,
    this.width,
    this.onPressed,
    this.text = "",
    this.textStyle,
    this.autoFocus = false,
    this.focusNode,
    this.enabled = true,
    this.loading = false,
  }) : super(key: key);

  const CustomGradientButton.small({
    Key? key,
    this.elevation = 0.0,
    this.borderRadius,
    this.padding,
    required this.gradient,
    this.uppercase = true,
    this.foregroundColor,
    this.icon,
    this.margin,
    this.width,
    this.onPressed,
    this.text = "",
    this.textStyle,
    this.autoFocus = false,
    this.focusNode,
    this.enabled = true,
    this.loading = false,
    this.textSize = 13,
    this.height = 35,
    this.iconSize = 13,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = <MaterialState>{};

    Color currentForegroundColor = foregroundColor ?? gradient.colors[0].contrast(context);

    // TextStyle
    TextStyle currentTextStyle;
    if (textStyle != null) {
      currentTextStyle = textStyle!;
    } else {
      currentTextStyle = theme.elevatedButtonTheme.style?.textStyle?.resolve(s) ?? const TextStyle();
    }

    // Shape
    RoundedRectangleBorder? currentState = theme.elevatedButtonTheme.style?.shape?.resolve(s) as RoundedRectangleBorder?;
    final currentBorderRadius = borderRadius != null ? BorderRadius.circular(borderRadius!) : (currentState?.borderRadius ?? BorderRadius.zero);
    RoundedRectangleBorder currentShape = RoundedRectangleBorder(
      borderRadius: currentBorderRadius,
      side: BorderSide.none,
    );

    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: Container(
        margin: margin,
        child: Material(
          color: Colors.transparent,
          elevation: elevation,
          borderRadius: currentBorderRadius,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: currentShape.borderRadius,
            ),
            child: RawMaterialButton(
              onPressed: loading ? () {} : onPressed,
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0),
              autofocus: autoFocus,
              focusNode: focusNode,
              elevation: elevation,
              focusElevation: 0,
              disabledElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              shape: currentShape,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomAnimatedFadeVisibility(
                    visible: !loading,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          Container(
                            margin: EdgeInsets.only(right: text.trim().isNotEmpty ? 5.0 : 0.0),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                icon,
                                key: ValueKey(icon),
                                color: currentTextStyle.copyWith(color: currentForegroundColor).color,
                                size: iconSize,
                              ),
                            ),
                          ),
                        Text(
                          uppercase ? text.toUpperCase() : text,
                          style: currentTextStyle.copyWith(color: currentForegroundColor, fontSize: textSize),
                        ),
                      ],
                    ),
                  ),
                  CustomAnimatedFadeVisibility(
                    visible: loading,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: currentTextStyle.copyWith(color: currentForegroundColor).color,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
