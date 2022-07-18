import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool loading;
  final Color? loadingColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? leading;
  final List<Widget> actionButtons;
  final String title;
  final String subtitle;
  final Widget? child;
  final Brightness brightness;
  final Widget? overlay;
  final bool statusBar;
  final Function()? onPressed;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Color? titleColor;
  final Key? actionButtonsKey;
  final double iconsPadding;

  const CustomAppBar({
    Key? key,
    this.loading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.loadingColor,
    this.leading,
    this.actionButtons = const [],
    this.title = "",
    this.subtitle = "",
    this.child,
    this.brightness = Brightness.dark,
    this.overlay,
    this.statusBar = true,
    this.onPressed,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.titleColor,
    this.actionButtonsKey,
    this.iconsPadding = 10.0,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60.0);

  @override
  Widget build(BuildContext context) {
    final currentBackgroundColor = backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor ?? Colors.transparent;
    final currentLoadingColor = loadingColor ?? currentBackgroundColor.contrast(context);
    final currentForegroundColor = foregroundColor ?? Theme.of(context).appBarTheme.foregroundColor ?? Colors.transparent;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: brightness,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: currentBackgroundColor,
          boxShadow: kElevationToShadow[Theme.of(context).appBarTheme.elevation],
        ),
        padding: EdgeInsets.only(top: statusBar ? MediaQuery.of(context).padding.top : 0.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: double.infinity,
              child: Row(
                children: [
                  if (leading != null)
                    CustomAnimatedFadeVisibility(
                      minOpacity: 0.5,
                      visible: !loading,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: leading!,
                      ),
                    ),
                  if (leading == null) const SizedBox(width: 16.0),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: onPressed,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: child != null
                            ? SizedBox(
                                width: double.infinity,
                                key: const ValueKey("child"),
                                child: child!,
                              )
                            : SizedBox(
                                width: double.infinity,
                                key: const ValueKey("content"),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 300),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        key: ValueKey(title),
                                        child: Text(
                                          title,
                                          maxLines: 1,
                                          style: titleTextStyle ??
                                              Theme.of(context).textTheme.titleMedium?.copyWith(color: titleColor ?? currentForegroundColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    CustomAnimatedCollapseVisibility(
                                      visible: subtitle.trim().isNotEmpty,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          width: double.infinity,
                                          key: ValueKey(subtitle),
                                          child: Text(
                                            subtitle,
                                            maxLines: 1,
                                            style: subtitleTextStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: currentForegroundColor),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  CustomAnimatedFadeVisibility(
                    visible: !loading,
                    minOpacity: 0.5,
                    child: CustomAnimatedSwitcher(
                      alignment: Alignment.centerRight,
                      child: Container(
                        key: actionButtonsKey,
                        margin: EdgeInsets.only(left: iconsPadding, right: iconsPadding),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: actionButtons,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomAnimatedFadeVisibility(
              visible: loading,
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                color: currentLoadingColor,
              ),
            ),
            if (overlay != null) overlay!,
          ],
        ),
      ),
    );
  }
}
