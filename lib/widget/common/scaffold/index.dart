import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';

class CustomScaffold extends HookConsumerWidget {
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Widget? body;
  final bool extentBody;
  final bool loading;
  final Future<bool> Function()? onWillPop;
  final Color? backgroundColor;
  final Widget? navigationBar;
  final bool extendBodyBehindAppBar;
  final double loadingMinOpacity;
  final Key? floatingActionButtonKey;

  const CustomScaffold({
    Key? key,
    this.onWillPop,
    this.resizeToAvoidBottomInset = true,
    this.appbar,
    this.floatingActionButton,
    this.body,
    this.extentBody = false,
    this.loading = false,
    this.backgroundColor,
    this.navigationBar,
    this.extendBodyBehindAppBar = false,
    this.loadingMinOpacity = 0.5,
    this.floatingActionButtonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: appbar,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: CustomAnimatedSwitcher(
            alignment: Alignment.bottomRight,
            child: Container(
              key: floatingActionButtonKey,
              child: floatingActionButton != null
                  ? CustomAnimatedFadeVisibility(
                      visible: !loading,
                      minOpacity: loadingMinOpacity,
                      child: floatingActionButton!,
                    )
                  : Container(),
            ),
          ),
          body: CustomAnimatedFadeVisibility(
            minOpacity: loadingMinOpacity,
            visible: !loading,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: body ?? Container(),
            ),
          ),
          extendBody: extentBody,
          bottomNavigationBar: navigationBar != null
              ? CustomAnimatedFadeVisibility(
                  visible: !loading,
                  minOpacity: 0.5,
                  child: navigationBar,
                )
              : null,
        ),
      ),
    );
  }
}
