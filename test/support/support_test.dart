import 'dart:io';

import 'package:disk_space/disk_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:truvideo_enterprise/model/support_info.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/support/index.dart';

import 'support_test.mocks.dart';

@GenerateMocks([
  AppPackageInfo,
  AuthService,
  ConnectivityService,
  DateService,
  DeviceService,
  HttpService,
  DiskSpace,
])
main() {
  setUp(() async {
    await GetIt.I.reset();
  });

   WidgetsFlutterBinding.ensureInitialized();

  group(
    'SupportServiceImplTests',
    () {
      late MockAppPackageInfo appPackageInfo;
      late MockAuthService authService;
      late MockConnectivityService connectivityService;
      late MockDateService dateService;
      late MockDeviceService deviceService;
      late MockHttpService httpService;
      late MockDiskSpace diskSpace;
      

      setUp(() {
        appPackageInfo = MockAppPackageInfo();
        authService = MockAuthService();
        connectivityService = MockConnectivityService();
        dateService = MockDateService();
        deviceService = MockDeviceService();
        httpService = MockHttpService();
        diskSpace = MockDiskSpace();

        GetIt.I.registerSingleton<AuthService>(authService);
        GetIt.I.registerSingleton<ConnectivityService>(connectivityService);
        GetIt.I.registerSingleton<DateService>(dateService);
        GetIt.I.registerSingleton<DeviceService>(deviceService);
        GetIt.I.registerSingleton<HttpService>(httpService);

        
      });
      test(
        'Should be initialized',
        () {
          // Given
          final sut = SupportServiceImpl(
            baseURL: 'https://httpbin.org/',
            supportBaseURL: 'https://httpbin.org/id',
          );

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<SupportServiceImpl>());
        },
      );

      group(
        '.sendInfo()',
        () {
          test(
            'Check that posts parameters are corrects',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );
              final expectedData = {
                'appVersion': 'appVersion',
                'dateTime': 'dateTime',
                'phoneId': 'phoneId',
                'phoneType': 'phoneType',
                'phoneOsVersion': 'phoneOS',
                'wifiInternetSettings': 'wifiInternetSettings',
                'truVideoServer': 'truVideoServer',
                'memoryFree': '',
                'memoryTotal': '',
                'storageFree': '',
                'videoStored': '',
                'oldVideosStored': '-',
                'locationServices': '-',
                'location': '-',
                'accessToMicrophone': '',
                'notifications': '',
                'googlePlayAccount': '-',
                'networkType': '',
                'networkTest': '-',
                'bandwidthTest': '',
                'videoSettings': '',
                'comment': 'comment',
                'email': 'email',
                'phoneNumber': 'phone',
                'storageCleanupSchedule': '-',
                'battery': '',
                'videoFormat': '',
              };

              // When
              when(authService.token).thenReturn('foo');
              when(authService.accountUid).thenReturn('bar');
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel());

              await sut.sendInfo(
                  supportInfo: const SupportInfoModel(
                    appVersion: 'appVersion',
                    dateTime: 'dateTime',
                    dealerName: 'dealerName',
                    dealerUuid: 'dealerUuid',
                    phoneId: 'phoneId',
                    phoneOS: 'phoneOS',
                    phoneType: 'phoneType',
                    truVideoServer: 'truVideoServer',
                    userId: 'userId',
                    wifiInternetSettings: 'wifiInternetSettings',
                  ),
                  comment: 'comment',
                  email: 'email',
                  phone: 'phone');

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(),
                  contains('/api/v3/support?account-uid='));
              expect(captured[1], equals(expectedData));
              expect(captured[2]['x-authorization-truvideo'], equals('foo'));
            },
          );
        },
      );

      group(
        '.checkWifiInternetSettings()',
        () {
          test(
            'Check that isOnline method is called',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );

              // When
              when(connectivityService.isOnline())
                  .thenAnswer((_) async => true);

              await sut.checkWifiInternetSettings();

              // Then
              verify(connectivityService.isOnline()).called(1);
            },
          );

          test(
            'Should return a wifi Internet Settings',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );

              // When
              when(connectivityService.isOnline())
                  .thenAnswer((_) async => true);

              final result = await sut.checkWifiInternetSettings();

              // Then
              expect(result, equals('Internet Connected'));
            },
          );
        },
      );

      group(
        '.checkTruVideoServer()',
        () {
          test(
            'Check that the get parameters are correct',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );

              // When
              when(authService.token).thenReturn('foo');
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(),
              );

              await sut.checkTruVideoServer();

              final captured = verify(httpService.get(
                captureAny,
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(), contains('https://httpbin.org/'));
              expect(captured[1]['x-authorization-truvideo'], equals('foo'));
            },
          );

          test(
            'Should return Connect of type String in case of success',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );

              // When
              when(authService.token).thenReturn('foo');
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(),
              );

              final response = await sut.checkTruVideoServer();

              // Then
              expect(response, equals('Connected'));
            },
          );

          test(
            'Should return Not Connected of type String in case of error',
            () async {
              // Given
              final sut = SupportServiceImpl(
                baseURL: 'https://httpbin.org/',
                supportBaseURL: 'https://httpbin.org/id',
              );

              // When
              when(authService.token).thenReturn('foo');
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenThrow(const HttpException('Request fail'));

              final response = await sut.checkTruVideoServer();

              // Then
              expect(response, equals('Not Connected'));
            },
          );
        },
      );
    },
  );
}
