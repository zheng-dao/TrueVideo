import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';

import 'widget.dart';

GlobalKey<CustomSnackBackState>? _key;

OverlayState? _overlayState;

class CustomSnackBar {
  static overlayState(OverlayState? state) {
    _overlayState = state;
  }
}

Future<void> showCustomSnackBarError({
  String title = "",
  String body = "",
}) {
  return showCustomSnackBar(
    title: title,
    body: body,
    icon: Icons.error_outline,
    iconBackgroundColor: CustomColorsUtils.delete,
  );
}

Future<void> showCustomSnackBarSuccess({
  String title = "",
  String body = "",
}) {
  return showCustomSnackBar(
    title: title,
    body: body,
    icon: Icons.check,
    iconBackgroundColor: Colors.green.shade600.withOpacity(0.1),
    iconColor: Colors.green.shade600,
  );
}

Future<void> showCustomSnackBar({
  String title = "",
  Color? titleColor,
  String body = "",
  Color? bodyColor,
  IconData? icon,
  Color? backgroundColor,
  Color? iconBackgroundColor,
  Color? iconColor,
}) async {
  if (_overlayState == null || !_overlayState!.mounted) {
    log("No overlay available");
    return;
  }

  if (_key != null && _key!.currentState != null) {
    await _key?.currentState?.close();
  }

  _key = GlobalKey<CustomSnackBackState>();
  OverlayEntry? entry;

  final completer = Completer<void>();
  entry = OverlayEntry(
    builder: (context) => CustomSnackBack(
      key: _key,
      title: title,
      titleColor: titleColor,
      message: body,
      messageColor: bodyColor,
      icon: icon,
      iconColor: iconColor,
      iconBackgroundColor: iconBackgroundColor,
      backgroundColor: backgroundColor,
      close: () {
        entry?.remove();
      },
    ),
  );
  _overlayState!.insert(entry);
  return completer.future;
}
