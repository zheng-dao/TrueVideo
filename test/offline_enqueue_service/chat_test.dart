import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/chat.dart';

import 'chat_test.mocks.dart';

@GenerateMocks([LocalDatabaseService, MessagingService])
void main() {
  setUp(() async {
    await GetIt.I.reset();
  });

  group(
    'OfflineEnqueueChatServiceImpl',
    () {
      late MockLocalDatabaseService localDatabaseService;
      late MockMessagingService messagingService;

      setUp(
        () {
          localDatabaseService = MockLocalDatabaseService();
          messagingService = MockMessagingService();

          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I.registerSingleton<MessagingService>(messagingService);
        },
      );

      test(
        'Should be initialized',
        () {
          // Given
          final sut = OfflineEnqueueChatServiceImpl();

          // when, Then
          expect(sut, isA<OfflineEnqueueChatServiceImpl>());
        },
      );

      group(
        '_getAllItems()',
        () {
          test(
            'verify if getAll is called',
            () async {
              // Given
              final sut = OfflineEnqueueChatServiceImpl();
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
              const model2 = MessageModel(
                accountUID: 'accountUID',
                auxUID: 'auxUID',
                channelUID: 'channelUID',
                body: 'body',
                imageURL: 'imageURL',
              );

              // When
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);
              when(messagingService.createMessage(
                accountUID: anyNamed('accountUID'),
                auxUID: anyNamed('auxUID'),
                channelUID: anyNamed('channelUID'),
                message: anyNamed('message'),
              )).thenAnswer((_) async => model2);
              when(localDatabaseService.write(any, any, any)).thenAnswer(
                (_) async => 'fofo',
              );

              await sut.onProcess('uid');

              // Then
              verify(localDatabaseService.getAll(any)).called(1);
            },
          );

          test(
            'verify if createMessage is called',
            () async {
              // Given
              final sut = OfflineEnqueueChatServiceImpl();
              const model = [
                OfflineEnqueueItemModel(
                  uid: 'ad1',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'uid',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'ad3',
                  statusIndex: 2,
                  typeIndex: 2,
                ),
              ];
              const model2 = MessageModel(
                accountUID: 'accountUID',
                auxUID: 'auxUID',
                channelUID: 'channelUID',
                body: 'body',
                imageURL: 'imageURL',
              );

              // When
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);
              when(messagingService.createMessage(
                accountUID: anyNamed('accountUID'),
                auxUID: anyNamed('auxUID'),
                channelUID: anyNamed('channelUID'),
                message: anyNamed('message'),
              )).thenAnswer((_) async => model2);
              when(localDatabaseService.write(any, any, any)).thenAnswer(
                (_) async => 'fofo',
              );

              await sut.onProcess('uid');

              // Then
              verify(messagingService.createMessage(
                accountUID: anyNamed('accountUID'),
                auxUID: anyNamed('auxUID'),
                channelUID: anyNamed('channelUID'),
                message: anyNamed('message'),
              )).called(1);
            },
          );

          test(
            'verify if write is called',
            () async {
              // Given
              final sut = OfflineEnqueueChatServiceImpl();
              const model = [
                OfflineEnqueueItemModel(
                  uid: 'ad1',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'uid',
                  statusIndex: 1,
                  typeIndex: 1,
                ),
                OfflineEnqueueItemModel(
                  uid: 'ad3',
                  statusIndex: 2,
                  typeIndex: 2,
                ),
              ];
              const model2 = MessageModel(
                accountUID: 'accountUID',
                auxUID: 'auxUID',
                channelUID: 'channelUID',
                body: 'body',
                imageURL: 'imageURL',
              );

              // When
              when(localDatabaseService.getAll(any))
                  .thenAnswer((_) async => model);

              when(messagingService.createMessage(
                accountUID: anyNamed('accountUID'),
                auxUID: anyNamed('auxUID'),
                channelUID: anyNamed('channelUID'),
                message: anyNamed('message'),
              )).thenAnswer((_) async => model2);

              when(localDatabaseService.write(any, any, any)).thenAnswer(
                (_) async => model,
              );

              await sut.onProcess('uid');

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );
        },
      );
    },
  );
}
