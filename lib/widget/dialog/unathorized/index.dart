import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';

bool _dialogVisible = false;

showCustomDialogUnauthorized() async {
  if (_dialogVisible) return;
  _dialogVisible = true;

  await showCustomDialog(
    title: "User unauthorized",
    message: "Please log in again to continue",
    onWillPop: () async => false,
    dismissOnBackgroundPress: false,
    buttonsBuilder: (context, controller) => [
      CustomBorderButton.small(
        text: "Accept",
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
        },
      ),
    ],
  );
  _dialogVisible = false;
}
