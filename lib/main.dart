import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_twilio/flutter_twilio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/service/biometric_login/_interface.dart';
import 'package:truvideo_enterprise/service/biometric_login/index.dart';
import 'package:truvideo_enterprise/service/checklist/_interface.dart';
import 'package:truvideo_enterprise/service/checklist/index.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/date/index.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';
import 'package:truvideo_enterprise/service/event_bus/index.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/index.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/service/messaging/index.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface_item.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/chat.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/index.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/log.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/unknown.dart';
import 'package:truvideo_enterprise/service/picture/index.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/index.dart';
import 'package:truvideo_enterprise/service/video_session/_interface.dart';
import 'package:truvideo_enterprise/service/video_session/index.dart';
import 'package:truvideo_enterprise/service/voip/_interface.dart';
import 'package:truvideo_enterprise/service/voip/index.dart';
import 'package:truvideo_enterprise/service/support/_interface.dart';
import 'package:truvideo_enterprise/service/support/index.dart';
import 'package:truvideo_enterprise/widget/dialog/unathorized/index.dart';
import 'dart:ui' as ui;

import 'core/env.dart';
import 'service/auth/_interface.dart';
import 'service/auth/index.dart';
import 'service/connectivity/_interface.dart';
import 'service/connectivity/index.dart';
import 'service/date/_interface.dart';
import 'service/date/index.dart';
import 'service/device/_interface.dart';
import 'service/device/index.dart';
import 'service/file_bucket/_interface.dart';
import 'service/file_bucket/s3.dart';
import 'service/http/_interface.dart';
import 'service/http/http.dart';
import 'service/local/_interface.dart';
import 'service/local/index.dart';
import 'service/local_db/_interface.dart';
import 'service/local_db/index.dart';
import 'service/location/_interface.dart';
import 'service/location/index.dart';
import 'service/messaging/_interface.dart';
import 'service/messaging/index.dart';
import 'service/offline_enqueue_service/_interface.dart';
import 'service/offline_enqueue_service/_interface_item.dart';
import 'service/offline_enqueue_service/chat.dart';
import 'service/offline_enqueue_service/index.dart';
import 'service/offline_enqueue_service/ro_video_upload.dart';
import 'service/phone_number/_interface.dart';
import 'service/phone_number/index.dart';
import 'service/picture/_interface.dart';
import 'service/push_notification/_interface.dart';
import 'service/push_notification/index.dart';
import 'service/repair_order/_interface.dart';
import 'service/repair_order/index.dart';
import 'service/settings/_interface.dart';
import 'service/settings/index.dart';
import 'service/voip/_interface.dart';
import 'service/voip/index.dart';
import 'widget/app.dart';
import 'dart:async';

final appKey = GlobalKey<CustomAppState>();

enum AppBuildMode {
  beta,
  rc,
  prod,
}

extension AppBuildModeExtension on AppBuildMode {
  String get value {
    switch (this) {
      case AppBuildMode.beta:
        return "BETA";
      case AppBuildMode.rc:
        return "RC";
      case AppBuildMode.prod:
        return "PROD";
    }
  }
}

run({required AppBuildMode mode}) async {
  runZonedGuarded<Future<void>>(
    () async {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await Firebase.initializeApp(options: CustomEnv.getFirebaseOptions(mode));
      await initializeDateFormatting();
      await Hive.initFlutter();
      await FlutterLibphonenumber().init();
      FlutterTwilio.init();
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      final truvideoBaseURL = CustomEnv.getBaseTruvideoURL(mode);
      final messagingBaseURL = CustomEnv.getBaseMessagingURL(mode);
      final repairOrderBaseURL = CustomEnv.getBaseRepairOrderURL(mode);
      final supportBaseURL = CustomEnv.getBaseSupportURL(mode);
      final securityToken = CustomEnv.getSecurityToken(mode);
      final sharedPreferences = await StreamingSharedPreferences.instance;
      final checklistURL = CustomEnv.getBaseChecklistURL(mode);
      final eventLogsURL = CustomEnv.getBaseEventLogsURL(mode);
      final httpService = HttpServiceImpl();
      httpService.addInterceptorException(401, () {
        showCustomDialogUnauthorized();
      });

      GetIt.I.registerSingleton<HttpService>(httpService);
      GetIt.I.registerSingleton<AuthService>(AuthServiceImpl(baseURL: truvideoBaseURL, securityToken: securityToken));
      GetIt.I.registerSingleton<LocalService>(LocalServiceImpl(sharedPreferences: sharedPreferences));
      GetIt.I.registerSingleton<PushNotificationService>(PushNotificationServiceImpl());
      GetIt.I.registerSingleton<LocalDatabaseService>(LocalDatabaseServiceImpl());
      GetIt.I.registerSingleton<DeviceService>(DeviceServiceImpl());
      GetIt.I.registerSingleton<LocationService>(LocationServiceImpl());
      GetIt.I.registerSingleton<ConnectivityService>(ConnectivityServiceImpl());
      GetIt.I.registerSingleton<ChecklistService>(ChecklistServiceImpl(baseURL: checklistURL, securityToken: securityToken));
      GetIt.I.registerSingleton<RepairOrderService>(RepairOrderServiceImpl(baseURL: repairOrderBaseURL));
      GetIt.I.registerSingleton<PhoneNumberService>(PhoneNumberServiceImpl());
      GetIt.I.registerSingleton<MessagingService>(MessagingServiceImpl(baseURL: messagingBaseURL));
      GetIt.I.registerSingleton<DateService>(DateServiceImpl(locale: ui.window.locale.languageCode));
      GetIt.I.registerSingleton<VoipService>(VoipServiceImpl(baseURL: messagingBaseURL));
      GetIt.I.registerSingleton<SettingsService>(SettingsServiceImpl());
      GetIt.I.registerSingleton<SupportService>(SupportServiceImpl(baseURL: truvideoBaseURL, supportBaseURL: supportBaseURL));
      GetIt.I.registerSingleton<FileBucketService>(FileBucketS3ServiceImpl());
      GetIt.I.registerSingleton<LogEventService>(LogEventServiceImpl(baseURL: eventLogsURL));
      GetIt.I.registerSingleton<OfflineEnqueueService>(OfflineEnqueueServiceImpl());
      GetIt.I.registerSingleton<VideoSessionService>(VideoSessionServiceImpl());
      GetIt.I.registerSingleton<PictureService>(PictureServiceImpl());
      GetIt.I.registerSingleton<EventBusService>(EventBusServiceImpl());
      GetIt.I.registerSingleton<BiometricLoginService>(BiometricLoginServiceImpl());

      for (var type in OfflineEnqueueItemType.values) {
        switch (type) {
          case OfflineEnqueueItemType.chat:
            GetIt.I.registerSingleton<OfflineEnqueueItemService>(OfflineEnqueueChatServiceImpl(), instanceName: type.eventKey);
            break;
          case OfflineEnqueueItemType.repairOrderVideoUpload:
            GetIt.I.registerSingleton<OfflineEnqueueItemService>(OfflineEnqueueVideoUploadServiceImpl(), instanceName: type.eventKey);
            break;
          case OfflineEnqueueItemType.log:
            GetIt.I.registerSingleton<OfflineEnqueueItemService>(OfflineEnqueueLogServiceImpl(), instanceName: type.eventKey);
            break;
          case OfflineEnqueueItemType.unknown:
            GetIt.I.registerSingleton<OfflineEnqueueItemService>(OfflineEnqueueUnknownServiceImpl(), instanceName: type.eventKey);
            break;
        }
      }

      runApp(
        ProviderScope(
          child: CustomApp(
            key: appKey,
            appBuildMode: mode,
          ),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 100));
      FlutterNativeSplash.remove();
    },
    (error, stack) {
      log("Global error", error: error, stackTrace: stack);
      FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}
