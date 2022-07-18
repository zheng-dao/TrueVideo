import 'dart:developer';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CustomPermissionUtils {
  static List<Permission> get photoCameraPermissions => [Permission.camera];

  static List<Permission> get videoCameraPermissions => [Permission.camera, Permission.microphone];

  static List<Permission> get galleryPermissions => [Platform.isAndroid ? Permission.storage : Permission.photos];

  static Future<bool> ask(List<Permission> p) async {
    final result = await askStatus(p);
    return !result.entries.any((e) => !e.value.isGranted);
  }

  static Future<bool> check(List<Permission> p) async {
    final result = await checkStatus(p);
    return !result.entries.any((e) => !e.value.isGranted);
  }

  static Future<Map<Permission, PermissionStatus>> askStatus(List<Permission> p) async {
    final result = <Permission, PermissionStatus>{};
    for (Permission element in p) {
      final status = await element.status;
      log("Current status for $element: $status");

      final newStatus = await element.request();
      log("New status for $element: $newStatus");

      result[element] = newStatus;
    }

    return result;
  }

  static Future<Map<Permission, PermissionStatus>> checkStatus(List<Permission> p) async {
    final result = <Permission, PermissionStatus>{};
    for (var element in p) {
      final status = await element.status;
      log("Current status for $element: $status");
      result[element] = status;
    }

    return result;
  }
}
