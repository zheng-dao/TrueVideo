import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/index.dart';
import 'package:truvideo_enterprise/service/log_event/model/module.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import 'index_test.mocks.dart';

@GenerateMocks([
  HttpService,
  AuthService,
  DeviceService,
  OfflineEnqueueService,
  FirebaseAnalytics,
])
void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  
  
  setUp(
    () {
      GetIt.I.reset();
    },
  );
  late MockAuthService authService;
  late MockDeviceService deviceService;
  late MockOfflineEnqueueService offlineEnqueueService;
  late MockHttpService httpService;
  late MockFirebaseAnalytics analytics;
  group(
    'LogEventServiceImpl',
    () {
      setUp(
        () {
          authService = MockAuthService();
          deviceService = MockDeviceService();
          offlineEnqueueService = MockOfflineEnqueueService();
          httpService = MockHttpService();
          analytics = MockFirebaseAnalytics();

          GetIt.I.registerSingleton<AuthService>(authService);
          GetIt.I.registerSingleton<DeviceService>(deviceService);
          GetIt.I
              .registerSingleton<OfflineEnqueueService>(offlineEnqueueService);
          GetIt.I.registerSingleton<HttpService>(httpService);
        },
      );

      group(
        'logScreen',
        () {
          test(
            ' verify that setCurrentScreen is called ',
            () async {
              // Given
              final sut = LogEventServiceImpl(
                baseURL: 'www.111.com',
                analytics: analytics,
              );

              // When
              when(analytics.setCurrentScreen(
                      screenName: anyNamed('screenName')))
                  .thenAnswer((_) async => 'screen');
              await sut.logScreen('screenName');

              // Then
              verify(analytics.setCurrentScreen(
                      screenName: anyNamed('screenName')))
                  .called(1);
            },
          );
        },
      );

      group(
        'logEvent',
        () {
          test(
            ' ----- ',
            () async {
              // Given
              final sut = LogEventServiceImpl(
                baseURL: 'www.111.com',
              );
              const module = LogEventModule.camera;
              const model = OfflineEnqueueItemModel(
                data: {
                  "moduleIndex": 1,
                  "action": 'action',
                  "levelIndex": 2,
                  "message": 'message',
                  "raw": 'raw',
                  "orderID": 'orderID',
                },
                typeIndex: 1,
              );

              // When
              when(offlineEnqueueService.enqueue(model))
                  .thenAnswer((_) async => model);
              await sut.logEvent(module);

              // Then
            },
          );
        },
      );
    },
  );
}
