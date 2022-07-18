import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/device_info.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:battery_plus/battery_plus.dart';

///{@template platform_info}
/// Model representing the platform information.
///
///{@endtemplate}
class PlatformInfo {
  /// Whether the running Platform is android.
  final bool isAndroid;

  /// Whether the running Platform is iOS.
  final bool isIOS;

  /// Whether the running Platform is web.
  final bool isWeb;

  //#region Initializers

  PlatformInfo({bool? isAndroid, bool? isIOS, bool? isWeb})
      : isAndroid = isAndroid ?? Platform.isAndroid,
        isIOS = isIOS ?? Platform.isIOS,
        isWeb = isWeb ?? kIsWeb;

//#endregion
}

class DeviceServiceImpl extends DeviceService {
  final DeviceInfoPlugin _deviceInfoPlugin;
  final PlatformInfo _platformInfo;

  //#region Initializers

  DeviceServiceImpl({
    DeviceInfoPlugin? deviceInfoPlugin,
    PlatformInfo? platformInfo,
    PackageInfo? packageInfo,
  })  : _deviceInfoPlugin = deviceInfoPlugin ?? DeviceInfoPlugin(),
        _platformInfo = platformInfo ?? PlatformInfo();

  //#endregion
  @override
  Future<String> getBatteryLevel() async {
    String result = '-';
    try {
      var battery = Battery();
      final batteryLevel = await battery.batteryLevel;
      result = "$batteryLevel%";
    } catch (e) {
      log("$e");
    }
    return result;
  }

  @override
  Future<DeviceInfoModel> getInfo() async {
    if (_platformInfo.isWeb) {
      final info = await _deviceInfoPlugin.webBrowserInfo;
      return DeviceInfoModel(
        id: "",
        name: info.browserName.name,
        manufacturer: info.platform ?? "",
        model: info.vendor ?? "",
        phoneOS: "",
      );
    }

    if (_platformInfo.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      return DeviceInfoModel(
        id: info.androidId ?? "",
        name: info.device ?? "",
        manufacturer: info.manufacturer ?? "",
        model: info.model ?? "",
        phoneOS: info.version.release ?? "",
      );
    }

    if (_platformInfo.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;

      return DeviceInfoModel(
        id: info.identifierForVendor ?? "",
        name: info.utsname.machine ?? "",
        manufacturer: "Apple",
        model: info.model ?? "",
        phoneOS: info.systemVersion ?? "",
      );
    }

    throw CustomException(message: "Unknown device type");
  }

  PackageInfo? _info;

  @override
  Future<String> getPackageVersion() async {
    _info ??= await PackageInfo.fromPlatform();
    return _info?.version ?? "";
  }

  @override
  Future<String> getPackageBuildNumber() async {
    _info ??= await PackageInfo.fromPlatform();
    return _info?.buildNumber ?? "";
  }
}
