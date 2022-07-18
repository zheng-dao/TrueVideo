import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';

import 'widget.dart';

BuildContext? _context;

class CustomCamera {
  static set context(BuildContext? context) {
    _context = context;
  }
}

Future<CameraResultModel?> showCustomCameraVideo({
  String videoSessionTag = "",
  String videoSessionUID = "",
  int? orderID,
}) async {
  final context = _context;
  if (context == null) return null;
  final result = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: CustomCameraWidget(
          mode: CustomCameraMode.video,
          videoSessionTag: videoSessionTag,
          videoSessionUID: videoSessionUID,
          orderID: orderID,
        ),
      ),
    ),
  );

  if (result != null && result is CameraResultModel) {
    return result;
  }

  return null;
}
