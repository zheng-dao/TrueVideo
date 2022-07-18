import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/device/index.dart';

import 'device_test.mocks.dart';

@GenerateMocks([
  AndroidDeviceInfo,
  DeviceInfoPlugin,
  WebBrowserInfo,
  IosDeviceInfo,
])
void main() {
  group(
    'DeviceServiceImplTests',
    () {
      late MockDeviceInfoPlugin deviceInfoPlugin;

      setUp(() {
        deviceInfoPlugin = MockDeviceInfoPlugin();
      });

      test(
        'Should be init|ialized',
        () {
          // Given
          final platformInfo = PlatformInfo(isIOS: true);
          final sut = DeviceServiceImpl(
            platformInfo: platformInfo,
            deviceInfoPlugin: deviceInfoPlugin,
          );

          // When, Then
          expect(sut, isA<DeviceServiceImpl>());
        },
      );
      group(
        '.getInfo()',
        () {
          test(
            'Should return DeviceInfoModel if kIsWeb is true',
            () async {
              // Given
              final webBrowserInfo = MockWebBrowserInfo();
              final platformInfo = PlatformInfo(isWeb: true);
              final sut = DeviceServiceImpl(
                  platformInfo: platformInfo,
                  deviceInfoPlugin: deviceInfoPlugin);

              // When
              when(deviceInfoPlugin.webBrowserInfo)
                  .thenAnswer((_) async => webBrowserInfo);
              when(webBrowserInfo.browserName)
                  .thenAnswer((_) => BrowserName.chrome);
              when(webBrowserInfo.platform).thenAnswer((_) => 'foo');
              when(webBrowserInfo.vendor).thenAnswer((_) => 'bar');

              final result = await sut.getInfo();

              // Then
              verify(deviceInfoPlugin.webBrowserInfo).called(1);
              expect(result.id, isEmpty);
              expect(result.name, equals('chrome'));
              expect(result.manufacturer, equals('foo'));
              expect(result.model, equals('bar'));
            },
          );

          test(
            'Should return DeviceInfoModel if isAndroid is true',
            () async {
              // Given
              final androidDeviceInfo = MockAndroidDeviceInfo();
              final platformInfo = PlatformInfo(isAndroid: true);
              final sut = DeviceServiceImpl(
                platformInfo: platformInfo,
                deviceInfoPlugin: deviceInfoPlugin,
              );

              final diviceInfoMap = {
                'id': 'androidId',
                'host': 'host',
                'tags': 'tags',
                'type': 'type',
                'model': 'model',
                'board': 'board',
                'brand': 'brand',
                'device': 'divice name',
                'product': 'product',
                'display': 'display',
                'hardware': 'hardware',
                'androidId': 'androidId',
                'bootloader': 'bootloader',
                'version': {
                  'baseOS': 'baseOS',
                  'sdkInt': 1,
                  'release': 'release',
                  'codename': 'codename',
                  'incremental': 'incremental',
                  'previewSdkInt': 1,
                  'securityPatch': 'securityPatch',
                },
                'fingerprint': 'fingerprint',
                'manufacturer': 'manufacturer',
                'supportedAbis': [],
                'systemFeatures': [],
                'isPhysicalDevice': true,
                'supported32BitAbis': [],
                'supported64BitAbis': [],
              };

              // When
              when(
                deviceInfoPlugin.androidInfo,
              ).thenAnswer(
                  (_) async => AndroidDeviceInfo.fromMap(diviceInfoMap));

              final result = await sut.getInfo();

              // Then
              expect(result.id, equals('androidId'));
              expect(result.name, equals('divice name'));
              expect(result.manufacturer, equals('manufacturer'));
              expect(result.model, equals('model'));
              expect(result.phoneOS, equals('release'));
            },
          );

          test(
            'Should return DeviceInfoModel if isIOS is true',
            () async {
              // Given
              final iosDeviceInfo = MockIosDeviceInfo();
              final platformInfo = PlatformInfo(isIOS: true);
              final sut = DeviceServiceImpl(
                platformInfo: platformInfo,
                deviceInfoPlugin: deviceInfoPlugin,
              );
              final iosDiviceInfoMap = {
                'name': 'name',
                'model': 'model',
                'systemName': 'systemName',
                'utsname': {
                  'release': 'release',
                  'version': 'version',
                  'machine': 'machine',
                  'sysname': 'sysname',
                  'nodename': 'nodename',
                },
                'systemVersion': 'systemVersion',
                'localizedModel': 'localizedModel',
                'identifierForVendor': 'identifierForVendor',
                'isPhysicalDevice': true,
              };

              // When
              when(
                deviceInfoPlugin.iosInfo,
              ).thenAnswer(
                  (_) async => IosDeviceInfo.fromMap(iosDiviceInfoMap));

              final result = await sut.getInfo();

              // Then
              expect(result.id, equals('identifierForVendor'));
              expect(result.name, equals('machine'));
              expect(result.manufacturer, equals('Apple'));
              expect(result.model, equals('model'));
            },
          );

          test(
            'Should throw a exception if any type device is false',
            () async {
              // Given
              Object? error;
              final iosDeviceInfo = MockIosDeviceInfo();
              final platformInfo = PlatformInfo(isIOS: false);
              final sut = DeviceServiceImpl(
                platformInfo: platformInfo,
                deviceInfoPlugin: deviceInfoPlugin,
              );

              // When
              when(deviceInfoPlugin.iosInfo)
                  .thenAnswer((_) async => iosDeviceInfo);

              try {
                await sut.getInfo();
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );
    },
  );
}
