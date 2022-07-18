import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface_item.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/index.dart';

import 'index_test.mocks.dart';

@GenerateMocks([
  ConnectivityService,
  LocalDatabaseService,
  OfflineEnqueueItemService,
])
void main() {
  setUp(
    () async {
      await GetIt.I.reset();
    },
  );
  group(
    'OfflineEnqueueServiceImpl',
    () {
      late MockConnectivityService connectivityService;
      late MockLocalDatabaseService localDatabaseService;
      late MockOfflineEnqueueItemService offlineEnqueueItemService;

      setUp(
        () {
          offlineEnqueueItemService = MockOfflineEnqueueItemService();
          connectivityService = MockConnectivityService();
          localDatabaseService = MockLocalDatabaseService();

          GetIt.I.registerSingleton<ConnectivityService>(connectivityService);
          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I.registerSingleton<OfflineEnqueueItemService>(
              offlineEnqueueItemService,
              instanceName: 'chat');
        },
      );

      test(
        'Is initialized',
        () {
          // Given
          final sut = OfflineEnqueueServiceImpl();

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<OfflineEnqueueServiceImpl>());
        },
      );

      group(
        '.startService()',
        () {
          test(
            'verify if isOffline is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => true);

              await sut.startService();

              // Then
              verify(connectivityService.isOffline()).called(1);
            },
          );

          test(
            'verify if getAll is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [jsonEncode(model)]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'as');

              await sut.startService();

              // Then
              verify(localDatabaseService.getAll(any)).called(2);
            },
          );

          test(
            'verify if read is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 1,
              );
              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);

              await sut.startService();

              // Then
              verify(localDatabaseService.read(any, any)).called(3);
            },
          );

          test(
            'verify if onPending is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 1,
              );
              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(offlineEnqueueItemService.onPending(any))
                  .thenAnswer((_) async => OfflineEnqueueItemType.unknown);

              await sut.startService();

              // Then
              verify(offlineEnqueueItemService.onPending(any)).called(1);
            },
          );

          test(
            'verify if onProcess is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 0,
                typeIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(offlineEnqueueItemService.onProcess(any))
                  .thenAnswer((_) async => OfflineEnqueueItemStatus.processing);

              await sut.startService();

              // Then
              verify(offlineEnqueueItemService.onProcess(any)).called(1);
            },
          );

          test(
            'verify if onDone is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 0,
                typeIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              when(offlineEnqueueItemService.onDone(any))
                  .thenAnswer((_) async => OfflineEnqueueItemStatus.processing);

              await sut.startService();

              // Then
              verify(offlineEnqueueItemService.onDone(any)).called(1);
            },
          );

          test(
            'verify if onError is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 4,
                typeIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => [model]);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model.status.index);
              when(offlineEnqueueItemService.onError(any, any))
                  .thenAnswer((_) async => CustomException(message: 'failed'));

              await sut.startService();

              // Then
              verify(offlineEnqueueItemService.onError(any, any)).called(1);
            },
          );
        },
      );

      group(
        '.update()',
        () {
          test(
            'verify if write is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 4,
                typeIndex: 1,
              );

              // When
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => model);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);

              await sut.update(model);

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
          test(
            'verify if read is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 4,
                typeIndex: 1,
              );

              // When
              when(localDatabaseService.write(any, any, any))
                  .thenAnswer((_) async => model);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);

              await sut.update(model);

              // Then
              verify(localDatabaseService.read(any, any)).called(1);
            },
          );
        },
      );

      group(
        '.delete()',
        () {
          test(
            'verify if delete is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 4,
                typeIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              await sut.delete('uid');

              // Then
              verify(localDatabaseService.delete(any, any)).called(1);
            },
          );

          test(
            'verify if onDelete  is called',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 4,
                typeIndex: 1,
              );

              // When
              when(connectivityService.isOffline())
                  .thenAnswer((_) async => false);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              await sut.delete('uid');

              // Then
              verify(offlineEnqueueItemService.onDelete(any)).called(1);
            },
          );
        },
      );

      group(
        'stream',
        () {
          test('Should return an OfflineEnqueueItemModel list', () async {
            // Given
            List<OfflineEnqueueItemModel> results = [];
            final streamController =
                StreamController<List<OfflineEnqueueItemModel>>();
            final sut = OfflineEnqueueServiceImpl();
            const model = [
              OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 1,
                typeIndex: 1,
              ),
              OfflineEnqueueItemModel(
                uid: 'ad2',
                statusIndex: 1,
                typeIndex: 1,
              ),
              OfflineEnqueueItemModel(
                uid: 'ad3',
                statusIndex: 2,
                typeIndex: 2,
              ),
            ];

            final type = [
              OfflineEnqueueItemType.repairOrderVideoUpload,
              OfflineEnqueueItemType.chat,
              OfflineEnqueueItemType.log,
            ];
            final status = [
              OfflineEnqueueItemStatus.done,
              OfflineEnqueueItemStatus.error,
              OfflineEnqueueItemStatus.processing
            ];

            // When
            when(localDatabaseService.streamAll(any))
                .thenAnswer((_) => streamController.stream);

            sut.stream(type: type, status: status).listen((event) {
              results.addAll(event);
            });

            streamController.add(model);

            await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

            // Then
            expect(results, model);
          });
        },
      );

      group(
        '.getAll()',
        () {
          test(
            'return an OfflineEnqueueItemModel',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();

              final type = [
                OfflineEnqueueItemType.repairOrderVideoUpload,
                OfflineEnqueueItemType.chat,
                OfflineEnqueueItemType.log,
              ];
              final status = [
                OfflineEnqueueItemStatus.done,
                OfflineEnqueueItemStatus.error,
                OfflineEnqueueItemStatus.processing
              ];

              const model = [
                OfflineEnqueueItemModel(
                  uid: 'ad1',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'ad2',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'ad3',
                  statusIndex: 2,
                  typeIndex: 2,
                ),
              ];
              // When
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);
              final result = await sut.getAll(type: type, status: status);

              // then
              expect(result, model);
            },
          );

          test(
            'return [] if the model is not OfflineEnqueueItemModel',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();

              final type = [
                OfflineEnqueueItemType.repairOrderVideoUpload,
                OfflineEnqueueItemType.chat,
                OfflineEnqueueItemType.log,
              ];
              final status = [
                OfflineEnqueueItemStatus.done,
                OfflineEnqueueItemStatus.error,
                OfflineEnqueueItemStatus.processing
              ];

              // When
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => type);
              final result = await sut.getAll(type: type, status: status);

              // then
              expect(result, []);
            },
          );
        },
      );

      group(
        '.getByUID()',
        () {
          test(
            'return an OfflineEnqueueItemModel',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 1,
                typeIndex: 1,
              );

              // When
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              final result = await sut.getByUID('uid');

              // Then
              expect(result, model);
            },
          );
          test(
            'return null if an error parsing occurs',
            () async {
              // Given
              final sut = OfflineEnqueueServiceImpl();

              // When
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => []);
              final result = await sut.getByUID('uid');

              // Then
              expect(result, isNull);
            },
          );
        },
      );
      group(
        '.streamByUID()',
        () {
          test(
            'return a model OfflineEnqueueItemModel',
            () async {
              // Given
              final streamController =
                  StreamController<OfflineEnqueueItemModel>();
              final sut = OfflineEnqueueServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                statusIndex: 1,
                typeIndex: 1,
              );
              OfflineEnqueueItemModel? result;

              // When
              when(localDatabaseService.streamByKey(any, any))
                  .thenAnswer((_) => streamController.stream);

              sut.streamByUID('ad1').listen((event) {
                result = event;
              });

              streamController.add(model);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(result, model);
            },
          );
        },
      );
    },
  );
}
