import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';
import 'package:truvideo_enterprise/service/settings/index.dart';

import 'settings_test.mocks.dart';

@GenerateMocks([
  AuthService,
  LocalDatabaseService,
  LogEventService,
])
main() {
  setUp(
    () async {
      GetIt.I.reset();
    },
  );

  group(
    'SettingsServiceImpl',
    () {
      late MockAuthService authService;
      late MockLocalDatabaseService localDatabaseService;
      late MockLogEventService logEventService;

      setUp(
        () {
          authService = MockAuthService();
          localDatabaseService = MockLocalDatabaseService();
          logEventService = MockLogEventService();

          GetIt.I.registerSingleton<AuthService>(authService);
          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I.registerSingleton<LogEventService>(logEventService);
        },
      );
      test(
        'Is initialized',
        () {
          // Given
          final sut = SettingsServiceImpl();

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<SettingsServiceImpl>());
        },
      );

      group(
        '.getFontSize()',
        () {
          test(
            'Verify that read method is called',
            () {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('Bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'fu');

              sut.getFontSize();

              // Then

              verify(localDatabaseService.read(any, any)).called(1);
            },
          );
          test(
            'Should return .mediun if read is null',
            () async {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('Bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              final result = await sut.getFontSize();

              // Then
              expect(result, equals(SettingsFontSize.medium));
            },
          );

          test('Should return .small if read is not null', () async {
            // Given
            final sut = SettingsServiceImpl();
            const index = 0;

            // When
            when(authService.sub).thenReturn('Bar');
            when(localDatabaseService.read(any, any))
                .thenAnswer((_) async => index);

            final result = await sut.getFontSize();

            // Then
            expect(result, equals(SettingsFontSize.small));
          });

          test(
            'Shows an error if a failure occurs',
            () async {
              // Give
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('Bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'string');

              final result = await sut.getFontSize();

              // Then
              expect(result, SettingsFontSize.medium);
            },
          );
        },
      );

      group(
        '.setfontSize()',
        () {
          test(
            'Verify that read method is called',
            () async {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => 'String');

              sut.setFontSize(SettingsFontSize.small);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
        },
      );

      group(
        '.streamFontSize()',
        () {
          test(
            'Return .medium if is null',
            () async {
              // Given
              List<SettingsFontSize> results = [];
              final streamController = StreamController<SettingsFontSize>();
              final sut = SettingsServiceImpl();
              const settingsFontSize = SettingsFontSize.big;

              // When
              when(authService.sub).thenReturn('sub');
              when(
                localDatabaseService.streamByKey(any, any),
              ).thenAnswer((_) => streamController.stream);

              sut.streamFontSize().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(settingsFontSize);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(SettingsFontSize.medium));
            },
          );

          test(
            'Return .small if is not null',
            () async {
              // Given
              List<SettingsFontSize> results = [];
              final streamController = StreamController<int>();
              final sut = SettingsServiceImpl();
              const settingsFontSize = 0;

              // When
              when(authService.sub).thenReturn('sub');
              when(
                localDatabaseService.streamByKey(any, any),
              ).thenAnswer((_) => streamController.stream);

              sut.streamFontSize().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(settingsFontSize);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(SettingsFontSize.small));
            },
          );

          test(
            'Should return a .medium if throw error',
            () async {
              // Given
              List<SettingsFontSize> results = [];
              final streamController = StreamController<String>();
              final sut = SettingsServiceImpl();
              const settingsFontSize = 'foo';

              // When
              when(authService.sub).thenReturn('sub');
              when(
                localDatabaseService.streamByKey(any, any),
              ).thenAnswer((_) => streamController.stream);

              sut.streamFontSize().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(settingsFontSize);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(SettingsFontSize.medium));
            },
          );
        },
      );

      group(
        '.getCameraQuality()',
        () {
          test(
            'Verify that read method is called',
            () {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'fu');

              sut.getCameraQuality();

              // Then

              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test(
            'Should return .medium if read is null',
            () async {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              final result = await sut.getCameraQuality();

              // Then
              expect(result, equals(CameraQuality.medium));
            },
          );

          test(
            'Should return .high if read is not null',
            () async {
              // Given
              final sut = SettingsServiceImpl();
              const index = 2;

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => index);

              final result = await sut.getCameraQuality();

              // Then
              expect(result, equals(CameraQuality.high));
            },
          );

          test(
            'Shows an error if a failure occurs',
            () async {
              // Give
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'string');

              final result = await sut.getCameraQuality();

              // Then
              expect(result, CameraQuality.medium);
            },
          );
        },
      );

      group(
        '.setCameraQuality',
        () {
          test(
            'verify that write method is called',
            () {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => 'fu');

              sut.setCameraQuality(CameraQuality.high);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
        },
      );

      group(
        '.streamCameraQuality',
        () {
          test(
            'Return .medium if is null',
            () async {
              // Given
              List<CameraQuality> results = [];
              final streamController = StreamController<CameraQuality>();
              final sut = SettingsServiceImpl();
              const cameraQuality = CameraQuality.medium;

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamCameraQuality().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(cameraQuality);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(CameraQuality.medium));
            },
          );

          test(
            'Return .low if is not null',
            () async {
              // Given
              List<CameraQuality> results = [];
              final streamController = StreamController<int>();
              final sut = SettingsServiceImpl();
              const cameraQuality = 0;

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamCameraQuality().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(cameraQuality);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(CameraQuality.low));
            },
          );

          test(
            'Return .medium if is throw error',
            () async {
              // Given
              List<CameraQuality> results = [];
              final streamController = StreamController<String>();
              final sut = SettingsServiceImpl();
              const cameraQuality = 'foo';

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamCameraQuality().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(cameraQuality);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], equals(CameraQuality.medium));
            },
          );
        },
      );

      group(
        '.setDebug()',
        () {
          test('verify that write method is called', () {
            // Given
            final sut = SettingsServiceImpl();

            // When
            when(authService.sub).thenReturn('sub');
            when(localDatabaseService.write(any, any, any))
                .thenAnswer((_) async => 'String');

            sut.setDebug(true);

            // Then
            verify(localDatabaseService.write(any, any, any)).called(1);
          });
        },
      );

      group(
        '.isDebug()',
        () {
          test(
            'verify that read is called ',
            () {
              // Given
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'fu');

              sut.isDebug();

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );

          test('Should retunr false if is null', () async {
            // Given
            final sut = SettingsServiceImpl();

            // When
            when(authService.sub).thenReturn('bar');
            when(localDatabaseService.read(any, any))
                .thenAnswer((_) async => null);

            final result = await sut.isDebug();

            // Then
            expect(result, equals(false));
          });

          test(
            'Should return true if read is not null',
            () async {
              // Given
              final sut = SettingsServiceImpl();
              const index = 1;

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => true);

              final results = await sut.isDebug();
              // Then
              expect(results, equals(true));
            },
          );

          test(
            'Return an error if a failure occurs',
            () async {
              // Give
              final sut = SettingsServiceImpl();

              // When
              when(authService.sub).thenReturn('bar');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'string');

              final result = await sut.isDebug();

              // Then
              expect(result, false);
            },
          );
        },
      );

      group(
        '.streamIsDebug()',
        () {
          test(
            'Return false if is null ',
            () async {
              // Given
              List<bool> results = [];
              final streamController = StreamController();
              final sut = SettingsServiceImpl();
              const streamDebug = null;

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamIsDebug().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(streamDebug);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], false);
            },
          );

          test(
            'Return true if is not null ',
            () async {
              // Given
              List<bool> results = [];
              final streamController = StreamController<bool>();
              final sut = SettingsServiceImpl();
              const streamDebug = true;

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamIsDebug().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(streamDebug);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], true);
            },
          );

          test(
            'Return flase if is throw error ',
            () async {
              // Given
              List<bool> results = [];
              final streamController = StreamController();
              final sut = SettingsServiceImpl();
              const streamDebug = 'foao';

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamIsDebug().listen(
                (event) {
                  results.add(event);
                },
              );

              streamController.add(streamDebug);

              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  streamController.close();
                },
              );

              // Then
              expect(results[0], false);
            },
          );
        },
      );
    },
  );
}
