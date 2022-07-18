import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truvideo_enterprise/core/permission.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

import 'widget.dart';

Future<bool> showCustomPermissionDialog(List<Permission> permissions) async {
  bool result = await CustomPermissionUtils.ask(permissions);
  if (result == true) return true;

  await showCustomDialog(
    dismissOnBackgroundPress: false,
    onWillPop: () async => false,
    title: "Permission request",
    resizeToAvoidBottomInset: false,
    childPadding: EdgeInsets.zero,
    builder: (context, controller) => CustomDialogPermissions(
      permissions: permissions,
      onGranted: () {
        controller.close();
        result = true;
      },
      onDenied: () {
        controller.close();
        result = false;
      },
    ),
  );

  return result;
}
