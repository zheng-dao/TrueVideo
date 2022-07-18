import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/controller.dart';

import 'widget.dart';

BuildContext? _context;

class CustomDialog {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<T?> showCustomDialog<T>({
  String title = "",
  String message = "",
  bool dismissOnBackgroundPress = true,
  EdgeInsets? scrollPadding,
  EdgeInsets? titlePadding,
  EdgeInsets? messagePadding,
  EdgeInsets? childPadding,
  EdgeInsets? buttonsPadding,
  Widget Function(BuildContext context, CustomDialogController controller)? builder,
  List<Widget> Function(BuildContext context, CustomDialogController controller)? buttonsBuilder,
  bool resizeToAvoidBottomInset = false,
  Future<bool> Function()? onWillPop,
  CustomDialogController? controller,
}) async {
  final result = await Navigator.of(_context!, rootNavigator: true).push(
    PageRouteBuilder(
      transitionDuration: Duration.zero,
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => CustomDialogWidget(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        scrollPadding: scrollPadding,
        titlePadding: titlePadding,
        messagePadding: messagePadding,
        childPadding: childPadding,
        buttonsPadding: buttonsPadding,
        title: title,
        message: message,
        builder: builder,
        dismissOnBackgroundPress: dismissOnBackgroundPress,
        onWillPop: onWillPop,
        controller: controller,
        buttonsBuilder: buttonsBuilder,
        close: ({dynamic result}) => Navigator.of(_context!).pop(result),
      ),
    ),
  );

  if (result == null) return null;
  return result;
}

Future<bool> showCustomDialogRetry({
  String title = "Error",
  String message = "",
  bool retryButtonVisible = true,
  String retryButtonText = "Retry",
  bool cancelButtonVisible = true,
  String cancelButtonText = "Cancel",
  bool dismissOnBackgroundPress = true,
  bool resizeToAvoidBottomInset = false,
  Future<bool> Function()? onWillPop,
  CustomDialogController? controller,
  Widget Function(BuildContext context, CustomDialogController controller)? builder,
  dynamic error,
}) async {
  if (message.trim().isEmpty) {
    if (error != null && error is CustomException) {
      message = (error).message ?? "";
    }
  }

  final result = await showCustomDialog(
    title: title,
    message: message,
    dismissOnBackgroundPress: dismissOnBackgroundPress,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    controller: controller,
    onWillPop: onWillPop,
    builder: builder,
    buttonsBuilder: (context, controller) => [
      if (cancelButtonVisible)
        CustomBorderButton.small(
          borderColor: Theme.of(context).dividerColor,
          onPressed: () async {
            controller.close(result: false);
          },
          text: cancelButtonText,
        ),
      if (retryButtonVisible)
        CustomGradientButton.small(
          gradient: CustomColorsUtils.gradient,
          onPressed: () async {
            controller.close(result: true);
          },
          text: retryButtonText,
        ),
    ],
  );

  if (result == null) return false;
  return result;
}
