import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomListTile extends StatelessWidget {
  final EdgeInsets? contentPadding;
  final EdgeInsets? leadingPadding;
  final EdgeInsets? trailingPadding;

  final String titleText;
  final Widget? title;
  final TextStyle? titleStyle;
  final int? titleMaxLines;
  final Color? titleColor;

  final String subtitleText;
  final Widget? subtitle;
  final TextStyle? subtitleStyle;
  final int? subtitleMaxLines;
  final Color? subtitleColor;

  final Function()? onPressed;
  final Function()? onLongPressed;
  final bool selected;
  final Color? color;
  final Color? selectedColor;

  final Widget? leading;
  final bool dense;
  final String trailingText;
  final TextStyle? trailingStyle;
  final int? trailingMaxLines;
  final Widget? trailing;
  final Color? trailingColor;
  final bool enabled;

  const CustomListTile({
    Key? key,
    this.titleText = "",
    this.title,
    this.titleStyle,
    this.titleMaxLines = 1,
    this.subtitleText = "",
    this.subtitle,
    this.subtitleStyle,
    this.subtitleMaxLines = 1,
    this.onPressed,
    this.onLongPressed,
    this.selected = false,
    this.color,
    this.selectedColor,
    this.titleColor,
    this.subtitleColor,
    this.trailingText = "",
    this.trailingStyle,
    this.trailingMaxLines = 1,
    this.trailing,
    this.trailingColor,
    this.leading,
    this.dense = false,
    this.contentPadding,
    this.leadingPadding,
    this.trailingPadding,
    this.enabled = true,
  }) : super(key: key);

  bool get _withTitle {
    if (title != null) return true;
    if (titleText.trim().isNotEmpty) return true;
    return false;
  }

  bool get _withSubtitle {
    if (subtitle != null) return true;
    if (subtitleText.trim().isNotEmpty) return true;
    return false;
  }

  bool get _withTrailing {
    if (trailing != null) return true;
    if (trailingText.trim().isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? CustomColorsUtils.messageBubbleMe.withOpacity(0.0);
    final currentSelectedColor = selectedColor ?? CustomColorsUtils.messageBubbleMe;
    final currentColor = selected ? currentSelectedColor : defaultColor;

    final currentTitleColor = titleColor ?? currentColor.contrast(context);
    final currentTitleStyle = titleStyle ?? (Theme.of(context).textTheme.bodyMedium?.copyWith(color: currentTitleColor) ?? const TextStyle());

    final currentSubtitleColor = subtitleColor ?? currentColor.contrast(context);
    final currentSubtitleStyle = subtitleStyle ?? (Theme.of(context).textTheme.bodySmall?.copyWith(color: currentSubtitleColor) ?? const TextStyle());

    final currentTrailingColor = trailingColor ?? currentColor.contrast(context);
    final currentTrailingStyle = trailingStyle ?? (Theme.of(context).textTheme.caption?.copyWith(color: currentTrailingColor) ?? const TextStyle());

    return CustomAnimatedFadeVisibility(
      visible: enabled,
      minOpacity: 0.5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(color: currentColor),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            onLongPress: onLongPressed,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: dense ? 50 : 70,
              ),
              alignment: Alignment.centerLeft,
              padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.0, vertical: dense ? 0 : 4.0),
              child: Row(
                children: [
                  if (leading != null)
                    Container(
                      margin: leadingPadding ?? EdgeInsets.only(right: dense ? 8.0 : 16.0),
                      child: leading!,
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_withTitle)
                          DefaultTextStyle(
                            style: currentTitleStyle,
                            child: title ??
                                (titleText.trim().isNotEmpty
                                    ? Text(
                                        titleText,
                                        style: currentTitleStyle,
                                        maxLines: titleMaxLines,
                                      )
                                    : Container()),
                          ),
                        if (_withSubtitle)
                          DefaultTextStyle(
                            style: currentSubtitleStyle,
                            child: subtitle ??
                                (subtitleText.trim().isNotEmpty
                                    ? Text(
                                        subtitleText,
                                        style: currentSubtitleStyle,
                                        maxLines: subtitleMaxLines,
                                      )
                                    : Container()),
                          ),
                      ],
                    ),
                  ),
                  if (_withTrailing)
                    Container(
                      margin: trailingPadding ?? const EdgeInsets.only(left: 16.0),
                      child: DefaultTextStyle(
                        style: currentTrailingStyle,
                        child: trailing ??
                            (trailingText.trim().isNotEmpty
                                ? Text(
                                    trailingText,
                                    style: currentTrailingStyle,
                                    maxLines: trailingMaxLines,
                                  )
                                : Container()),
                      ),
                    ),
                ],
              ), // subtitle: _withSubtitle
            ),
          ),
        ),
      ),
    );
  }
}
