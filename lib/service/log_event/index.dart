import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/model/device_info.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';

import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

class LogEventServiceImpl implements LogEventService {
  final FirebaseAnalytics _analytics;
  final String baseURL;

  bool _isInit = false;
  DeviceInfoModel? _deviceInfo;
  String _packageVersion = "";
  String _packageBuildNumber = "";

  LogEventServiceImpl({required this.baseURL, FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  HttpService get _httpService => GetIt.I.get();

  AuthService get _authService => GetIt.I.get();

  DeviceService get _deviceService => GetIt.I.get();

  OfflineEnqueueService get _offlineEnqueueService => GetIt.I.get();

  // FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  _init() async {
    if (_isInit) return;
    _isInit = true;
    _deviceInfo = await _deviceService.getInfo();
    _packageVersion = await _deviceService.getPackageVersion();
    _packageBuildNumber = await _deviceService.getPackageBuildNumber();
  }

  Future<String> get _source async {
    await _init();
    return "${_deviceInfo?.manufacturer} ${_deviceInfo?.model} ${_deviceInfo?.name} ${_deviceInfo?.phoneOS}";
  }

  Future<String> get _version async {
    await _init();
    return "$_packageVersion $_packageBuildNumber";
  }

  @override
  Future<void> logScreen(String screenName) async {
    try {
      await _analytics.setCurrentScreen(screenName: screenName);
    } catch (error) {
      log("Error logging current screen");
    }
  }

  @override
  Future<void> logEvent(
    LogEventModule module, {
    String action = "",
    LogEventLevel? level,
    String message = "",
    String raw = "",
    int? orderID, 
  }) async {
    // await _logFirebaseAnalytics(title: title, message: message);
    await _logTruvideoAPI(
      module,
      action: action,
      level: level,
      message: message,
      raw: raw,
      orderID: orderID,
    );
  }

  _logTruvideoAPI(
    LogEventModule module, {
    String action = "",
    LogEventLevel? level,
    String message = "",
    String raw = "",
    int? orderID,
  }) async {
    await _offlineEnqueueService.enqueue(
      OfflineEnqueueItemModel(
        data: {
          "moduleIndex": module.index,
          "action": action,
          "levelIndex": level?.index,
          "message": message,
          "raw": raw,
          "orderID": orderID,
        },
        typeIndex: OfflineEnqueueItemType.log.index,
      ),
    );
  }

  //
  // _logFirebaseAnalytics({
  //   String title = "",
  //   String message = "",
  // }) async {
  //   try {
  //     await _analytics.logEvent(
  //       name: title,
  //       parameters: {
  //         "message": message,
  //       },
  //     );
  //   } catch (error) {
  //     log("Error logging to Firebase Analytics", error: error);
  //   }
  // }

  @override
  Future<void> logEventError(
    Exception err,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    // await crashlytics.recordError(err, stackTrace, reason: fatal ? 'a fatal error' : 'a non-fatal error', fatal: fatal);
  }

  @override
  Future<void> processLog(
    LogEventModule module, {
    String action = "",
    LogEventLevel? level,
    String message = "",
    String raw = "",
    int? orderID,
  }) async {
    try {
      final token = await _authService.token;
      final accountUID = _authService.accountUid;

      await _httpService.post(
        Uri.parse("$baseURL/api/v3/event-log"),
        params: {
          "account-uid": accountUID,
        },
        headers: {
          "X-Authorization-Truvideo": token,
        },
        data: {
          "source": await _source,
          "version": await _version,
          "module": module.eventName,
          "action": action,
          "level": level?.name ?? "",
          "message": message.length > 200 ? message.substring(0, 200) : message,
          "raw": raw,
          "orderId": orderID,
        },
      );
    } catch (error) {
      log("Error logging to Truvideo API", error: error);
    }
  }
}
