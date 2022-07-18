import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_text_switcher/index.dart';

class CustomBorderButton extends HookConsumerWidget {
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
  final Color? iconColor;
  final double? height;
  final bool loading;
  final bool uppercase;
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double textSize;
  final double iconSize;
  final Widget? child;
  final EdgeInsets? padding;
  final bool iconOnLeft;
  final Widget? iconWidget;

  const CustomBorderButton({
    Key? key,
    this.padding,
    this.child,
    this.splashColor,
    this.highlightColor,
    this.fillColor,
    this.iconColor,
    this.textColor,
    this.borderColor,
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
    this.textSize = 15,
    this.iconSize = 20,
    this.iconOnLeft = true,
    this.iconWidget,
  }) : super(key: key);

  const CustomBorderButton.small({
    Key? key,
    this.padding,
    this.child,
    this.splashColor,
    this.highlightColor,
    this.fillColor,
    this.iconColor,
    this.textColor,
    this.borderColor,
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
    this.iconSize = 13,
    this.height = 35,
    this.iconOnLeft = true,
    this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = <MaterialState>{};

    Color currentForegroundColor = foregroundColor ?? theme.backgroundColor.contrast(context);

    // TextStyle
    TextStyle currentTextStyle;
    if (textStyle != null) {
      currentTextStyle = textStyle!;
    } else {
      currentTextStyle = theme.elevatedButtonTheme.style?.textStyle?.resolve(s) ?? const TextStyle();
    }

    // Shape
    RoundedRectangleBorder? currentState = theme.elevatedButtonTheme.style?.shape?.resolve(s) as RoundedRectangleBorder?;
    RoundedRectangleBorder currentShape = RoundedRectangleBorder(
      borderRadius: currentState?.borderRadius ?? BorderRadius.zero,
      side: BorderSide(
        width: 1,
        color: borderColor ?? theme.dividerColor,
      ),
    );

    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: Container(
        width: width,
        margin: margin,
        height: height,
        child: RawMaterialButton(
          onPressed: loading ? () {} : onPressed,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 10.0),
          fillColor: fillColor,
          splashColor: splashColor,
          highlightColor: highlightColor,
          autofocus: autoFocus,
          focusNode: focusNode,
          elevation: 0,
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
                child: child ??
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if ((icon != null || iconWidget != null) && iconOnLeft)
                          Container(
                            margin: EdgeInsets.only(right: text.trim().isNotEmpty ? 5.0 : 0.0),
                            child: iconWidget ??
                                CustomAnimatedSwitcher(
                                  child: Icon(
                                    icon,
                                    key: ValueKey("$icon$iconSize${iconColor ?? textColor ?? currentForegroundColor}"),
                                    color: currentTextStyle.copyWith(color: iconColor ?? textColor ?? currentForegroundColor).color,
                                    size: iconSize,
                                  ),
                                ),
                          ),
                        if (text.trim().isNotEmpty)
                          CustomAnimatedTextSwitcher(
                            text: uppercase ? text.toUpperCase() : text,
                            textStyle: currentTextStyle.copyWith(color: textColor ?? currentForegroundColor, fontSize: textSize),
                          ),
                        if ((icon != null || iconWidget != null) && !iconOnLeft)
                          Container(
                            margin: EdgeInsets.only(left: text.trim().isNotEmpty ? 5.0 : 0.0),
                            child: iconWidget ??
                                CustomAnimatedSwitcher(
                                  child: Icon(
                                    icon,
                                    key: ValueKey("$icon$iconSize${iconColor ?? textColor ?? currentForegroundColor}"),
                                    color: currentTextStyle.copyWith(color: iconColor ?? textColor ?? currentForegroundColor).color,
                                    size: iconSize,
                                  ),
                                ),
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
    );
  }
}
