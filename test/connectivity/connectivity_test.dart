import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/index.dart';

import 'connectivity_test.mocks.dart';

@GenerateMocks([
  Connectivity,
  ConnectivityService,
])
main() {
  setUp(() async {
    await GetIt.I.reset();
  });
  group(
    'ConnectivityServiceImplTests',
    () {
      late MockConnectivity connectivity;
      late MockConnectivityService connectivityService;

      setUp(
        () {
          connectivity = MockConnectivity();
          connectivityService = MockConnectivityService();

          GetIt.I.registerSingleton<ConnectivityService>(connectivityService);
        },
      );

      test(
        'Should be initialized',
        () {
          // Given
          final sut = ConnectivityServiceImpl(connectivity: connectivity);

          // When, Then
          expect(sut, isA<ConnectivityServiceImpl>());
        },
      );
      group(
        '.isOffline()',
        () {
          test(
            'Should return true when is Offline',
            () async {
              // Given
              final sut = ConnectivityServiceImpl(connectivity: connectivity);

              // When
              when(connectivity.checkConnectivity())
                  .thenAnswer((_) async => ConnectivityResult.none);

              final result = await sut.isOffline();

              // Then
              expect(result, equals(true));
            },
          );
        },
      );

      group(
        '.isOnline()',
        () {
          test(
            'Should return true when is online',
            () async {
              // Given
              final sut = ConnectivityServiceImpl(connectivity: connectivity);

              // When
              when(connectivity.checkConnectivity())
                  .thenAnswer((_) async => ConnectivityResult.bluetooth);

              final result = await sut.isOnline();

              // Then
              expect(result, equals(true));
            },
          );
        },
      );

      group(
        '.offlineStream()',
        () {
          test(
            'Should listen stream',
            () async {
              // Given
              List<bool> results = [];
              final streamController = StreamController<ConnectivityResult>();
              final sut = ConnectivityServiceImpl(connectivity: connectivity);

              // When
              when(connectivity.onConnectivityChanged)
                  .thenAnswer((_) => streamController.stream);

              sut.offlineStream.listen((event) {
                results.add(event);
              });

              streamController.add(ConnectivityResult.none);
              streamController.add(ConnectivityResult.mobile);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals([true, false]));
            },
          );
        },
      );

      group(
        '.onlineStream()',
        () {
          test(
            'Should listen stream',
            () async {
              // Given
              List<bool> results = [];
              final streamController = StreamController<ConnectivityResult>();
              final sut = ConnectivityServiceImpl(connectivity: connectivity);

              // When
              when(connectivity.onConnectivityChanged)
                  .thenAnswer((_) => streamController.stream);

              sut.onlineStream.listen((event) {
                results.add(event);
              });

              streamController.add(ConnectivityResult.wifi);
              streamController.add(ConnectivityResult.none);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals([true, false]));
            },
          );
        },
      );

      group(
        '.validateOnline()',
        () {
          test(
            'Should throw a exception if is offline',
            () async {
              // Given
              Object? error;
              final sut = ConnectivityServiceImpl(connectivity: connectivity);

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => true);

              try {
                await sut.validateOnline();
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
