import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/local/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';

import 'font_size.dart';

class SettingsServiceImpl extends SettingsService {
  SettingsServiceImpl();

  LogEventService get _logEventService => GetIt.I.get();

  LocalDatabaseService get localDatabaseService => GetIt.I.get();

  LocalService get localService => GetIt.I.get();

  String _boxName(String userUUID) => "settings_$userUUID";

  @override
  Future<SettingsFontSize> getFontSize() async {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    final data = await localDatabaseService.read(boxName, "font-size");
    if (data == null) {
      return SettingsFontSize.medium;
    }

    try {
      return SettingsFontSize.values[data];
    } catch (error, stack) {
      log("Error parsing font size", error: error, stackTrace: stack);
      return SettingsFontSize.medium;
    }
  }

  @override
  Future<void> setFontSize(SettingsFontSize fontSize) async {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    await localDatabaseService.write(boxName, "font-size", fontSize.index);
  }

  @override
  Stream<SettingsFontSize> streamFontSize() {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    return localDatabaseService.streamByKey(boxName, "font-size").map((event) {
      if (event == null) {
        return SettingsFontSize.medium;
      }

      try {
        return SettingsFontSize.values[event];
      } catch (error, stack) {
        log("Error parsing font size", error: error, stackTrace: stack);
        return SettingsFontSize.medium;
      }
    });
  }

  @override
  Future<CameraQuality> getCameraQuality() async {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    final data = await localDatabaseService.read(boxName, "camera-quality");
    if (data == null) {
      return CameraQuality.medium;
    }

    try {
      return CameraQuality.values[data];
    } catch (error, stack) {
      log("Error parsing CameraQuality", error: error, stackTrace: stack);
      return CameraQuality.medium;
    }
  }

  @override
  Future<void> setCameraQuality(CameraQuality cameraQuality) async {
    _logEventService.logEvent(
      LogEventModule.settings,
      action: LogEventActionSettings.changeCameraQuality.eventName,
      level: LogEventLevel.info,
      raw: cameraQuality.name,
    );

    try {
      final AuthService authService = GetIt.I.get();
      final sub = authService.sub ?? "";
      final boxName = _boxName(sub);

      await localDatabaseService.write(
        boxName,
        "camera-quality",
        cameraQuality.index,
      );

      _logEventService.logEvent(
        LogEventModule.settings,
        action: LogEventActionSettings.changeCameraQualitySuccess.eventName,
        level: LogEventLevel.success,
        raw: cameraQuality.name,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.settings,
        action: LogEventActionSettings.changeCameraQualityError.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: cameraQuality.name,
      );

      rethrow;
    }
  }

  @override
  Stream<CameraQuality> streamCameraQuality() {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    return localDatabaseService.streamByKey(boxName, "camera-quality").map((event) {
      if (event == null) {
        return CameraQuality.medium;
      }

      try {
        return CameraQuality.values[event];
      } catch (error, stack) {
        log("Error parsing CameraQuality", error: error, stackTrace: stack);
        return CameraQuality.medium;
      }
    });
  }

  @override
  Future<void> setDebug(bool debug) async {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    await localDatabaseService.write(boxName, "debug", debug);
  }

  @override
  Future<bool> isDebug() async {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    final data = await localDatabaseService.read(boxName, "debug");
    if (data == null) {
      return false;
    }

    try {
      return data == true;
    } catch (error, stack) {
      log("Error parsing is debug", error: error, stackTrace: stack);
      return false;
    }
  }

  @override
  Stream<bool> streamIsDebug() {
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";
    final boxName = _boxName(sub);

    return localDatabaseService.streamByKey(boxName, "debug").map((event) {
      if (event == null) {
        return false;
      }

      try {
        return event == true;
      } catch (error, stack) {
        log("Error parsing is debug", error: error, stackTrace: stack);
        return false;
      }
    });
  }
}
