import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/log.dart';

import 'log_test.mocks.dart';

@GenerateMocks([
  LogEventService,
  LocalDatabaseService,
  OfflineEnqueueService,
])
void main() {
  setUp(() async {
    await GetIt.I.reset();
  });
  
  group(
    'OfflineEnqueueLogServiceImpl',
    () {
      late MockLogEventService logEventService;
      late MockLocalDatabaseService localDatabaseService;
      late MockOfflineEnqueueService offlineEnqueueService;

      setUp(
        () {
          logEventService = MockLogEventService();
          localDatabaseService = MockLocalDatabaseService();
          offlineEnqueueService = MockOfflineEnqueueService();

          GetIt.I.registerSingleton<LogEventService>(logEventService);
          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I
              .registerSingleton<OfflineEnqueueService>(offlineEnqueueService);
        },
      );

      test(
        'Is initialized',
        () {
          // Given
          final sut = OfflineEnqueueLogServiceImpl();

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<OfflineEnqueueLogServiceImpl>());
        },
      );

      group(
        '.onDone()',
        () {
          test(
            'verify if isOffline is called',
            () async {
              // Given
              final sut = OfflineEnqueueLogServiceImpl();

              // when
              when(localDatabaseService.delete(any, any))
                  .thenAnswer((_) async => 'fofu');
              await sut.onDone('uid');

              // Then
              verify(localDatabaseService.delete(any, any)).called(1);
            },
          );
        },
      );

      group(
        '.onProcess()',
        () {
          test(
            'verify if processLog is called',
            () async {
              // Given
              final sut = OfflineEnqueueLogServiceImpl();
              const model = OfflineEnqueueItemModel(
                  uid: 'ad1',
                  errorMessage: 'errorMessage',
                  statusIndex: 1,
                  data: {
                    'moduleIndex': 4,
                    'levelIndex': 1,
                  });

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(logEventService.processLog(
                any,
                action: anyNamed('action'),
                level: anyNamed('level'),
                message: anyNamed('message'),
                orderID: anyNamed('orderID'),
                raw: anyNamed('raw'),
              )).thenAnswer((_) async => 1223);
              await sut.onProcess('uid');

              // Then
              verify(logEventService.processLog(
                any,
                action: anyNamed('action'),
                level: anyNamed('level'),
                message: anyNamed('message'),
                orderID: anyNamed('orderID'),
                raw: anyNamed('raw'),
              )).called(1);
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              final sut = OfflineEnqueueLogServiceImpl();
              const model = OfflineEnqueueItemModel(
                uid: 'ad1',
                errorMessage: 'errorMessage',
                statusIndex: 1,
                data: {
                  'moduleIndex': 4,
                  'levelIndex': 1,
                  'message': 'message',
                  'orderID': 1,
                  'raw': 'raw',
                },
              );

              // When
              when(offlineEnqueueService.getByUID(any))
                  .thenAnswer((_) async => model);
              when(logEventService.processLog(
                any,
                action: anyNamed('action'),
                level: anyNamed('level'),
                message: anyNamed('message'),
                orderID: anyNamed('orderID'),
                raw: anyNamed('raw'),
              )).thenAnswer((_) async => 1223);

              await sut.onProcess('uid');

              final captured = verify(
                logEventService.processLog(
                  captureAny,
                  action: captureAnyNamed('action'),
                  level: captureAnyNamed('level'),
                  message: captureAnyNamed('message'),
                  orderID: captureAnyNamed('orderID'),
                  raw: captureAnyNamed('raw'),
                ),
              ).captured;

              // Then
              expect(captured[2], isA<LogEventLevel>());
              expect(captured[3], equals('message'));
              expect(captured[4], 1);
              expect(captured[5], equals('raw'));
            },
          );
        },
      );
    },
  );
}
