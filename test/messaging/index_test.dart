import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/message_authentication_information.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/message_member.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/messaging/index.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import 'index_test.mocks.dart';

@GenerateMocks([
  LocalDatabaseService,
  HttpService,
  AuthService,
  OfflineEnqueueService,
])
void main() {
  group(
    'MessagingServiceImpl',
    () {
      late MockLocalDatabaseService localDatabaseService;
      late MockHttpService httpService;
      late MockAuthService authService;
      late MockOfflineEnqueueService offlineEnqueueService;
      setUp(
        () {
          localDatabaseService = MockLocalDatabaseService();
          httpService = MockHttpService();
          authService = MockAuthService();
          offlineEnqueueService = MockOfflineEnqueueService();

          GetIt.I.registerSingleton<LocalDatabaseService>(localDatabaseService);
          GetIt.I.registerSingleton<HttpService>(httpService);
          GetIt.I.registerSingleton<AuthService>(authService);
          GetIt.I
              .registerSingleton<OfflineEnqueueService>(offlineEnqueueService);

          when(authService.token).thenReturn('fofo');
        },
      );

      group(
        '.getCachedAuthenticationInformation()',
        () {
          test(
            ' Should return MessageAuthenticationInformationModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = MessageAuthenticationInformationModel(
                accountUID: 'accountUID',
                authenticated: true,
              );

              // When
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => model);
              final result = await sut.getCachedAuthenticationInformation();

              // Then
              expect(result, model);
            },
          );
          test(
            ' Should return null if cached is null ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);

              // When
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);
              final result = await sut.getCachedAuthenticationInformation();

              // Then
              expect(result, null);
            },
          );

          test(
            ' Should return null if an Error parsing occurs  ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);

              // When
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => 'String is not a model');
              final result = await sut.getCachedAuthenticationInformation();

              // Then
              expect(result, null);
            },
          );
        },
      );

      group(
        '.authenticate()',
        () {
          test(
            ' Return a CustomExeption if token is null ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                  data: MessageAuthenticationInformationModel(
                accountUID: 'accountUID',
                provider: 'provider',
              ));

              // When
              when(authService.token).thenReturn(null);
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);

              // Then
              expect(() => sut.authenticate(), throwsA(isA<CustomException>()));
            },
          );
          test(
            ' Should return null if an Error parsing occurs',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                  data: MessageAuthenticationInformationModel(
                accountUID: 'accountUID',
                provider: 'provider',
              ));

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);
              final result = await sut.authenticate();

              // Then
              expect(result, null);
            },
          );

          test(
            ' Should return MessageAuthenticationInformationModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(data: {
                'accountUID': 'accountUID',
                'provider': 'provider',
              });
              const resultExpected = MessageAuthenticationInformationModel(
                accountUID: 'accountUID',
                provider: 'provider',
              );

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);
              final result = await sut.authenticate();

              // Then
              expect(result, resultExpected);
            },
          );

          test(
            ' Verify that .get() is called ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                data: {
                  'accountUID': 'accountUID',
                  'provider': 'provider',
                },
              );

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);
              await sut.authenticate();

              // Then
              verify(httpService.get(any, headers: anyNamed('headers')))
                  .called(1);
            },
          );

          test(
            ' Verify that .write() is called ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                data: {
                  'accountUID': 'accountUID',
                  'provider': 'provider',
                },
              );

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);
              await sut.authenticate();

              // Then
              verify(localDatabaseService.write(any, any, any)).called(1);
            },
          );

          test(
            ' Verify that .delete() is called ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(data: 'string');

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer((_) async => model);
              await sut.authenticate();

              // Then
              verify(localDatabaseService.delete(any, any)).called(1);
            },
          );
        },
      );

      group(
        'getMembersPaginated',
        () {
          test(
            ' Should return a MessageMemberModel list ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                data: [
                  {
                    "uid": 'uid',
                    "displayName": "displayName",
                    "channelUid": 'channelUid',
                    "unreadMessages": 10,
                    "pinned": true,
                    "enabled": true,
                  }
                ],
              );
              const expectedData = [
                MessageMemberModel(
                  uid: 'uid',
                  displayName: 'displayName',
                  channelUid: 'channelUid',
                  unreadMessages: 10,
                  pinned: true,
                  enabled: true,
                )
              ];

              // When
              when(authService.applicationUid).thenReturn('applicationUid');
              when(authService.sub).thenReturn('sub');
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => model);

              final result =
                  await sut.getMembersPaginated(accountUID: 'accountUID');
              // Then
              expect(result, expectedData);
            },
          );
        },
      );

      group(
        'getCachedMembers',
        () {
          test(
            ' Should return [] if data is null ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);

              // Then
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              final result = await sut.getCachedMembers();

              // When
              expect(result, []);
            },
          );

          test(
            ' Should return MessageMemberModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const expectedData = [
                {
                  "uid": "uid",
                  "displayName": "displayName",
                  "channelUid": "channelUid",
                  "unreadMessages": 10,
                  "pinned": true,
                  "enabled": true
                }
              ];

              const model = [
                MessageMemberModel(
                  uid: 'uid',
                  displayName: 'displayName',
                  channelUid: 'channelUid',
                  unreadMessages: 10,
                  pinned: true,
                  enabled: true,
                )
              ];

              // Then
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => jsonEncode(expectedData));

              final result = await sut.getCachedMembers();

              // When
              expect(result, model);
            },
          );
        },
      );

      group(
        'getMessages',
        () {
          test(
            ' Should return a MessageModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(
                data: [
                  {
                    'uid': 'uid',
                    'accountUID': 'accountUID',
                    'memberUID': 'memberUID',
                    'status': 'status',
                    'channelUID': 'channelUID',
                    'imageURL': 'imageURL',
                  },
                ],
              );
              const offlineModel = [
                OfflineEnqueueItemModel(uid: 'uid'),
              ];
              const expectedData = [
                MessageModel(
                  uid: 'uid',
                  accountUID: 'accountUID',
                  status: 'status',
                  channelUID: 'channelUID',
                  imageURL: 'imageURL',
                ),
              ];

              // When
              when(authService.sub).thenReturn('sub');
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => model);
              when(offlineEnqueueService.getAll(
                      type: anyNamed('type'), status: anyNamed('status')))
                  .thenAnswer((_) async => offlineModel);

              final result = await sut.getMessages(
                accountUID: 'accountUID',
                memberUID: 'memberUID',
              );

              // Then
              expect(result, expectedData);
            },
          );
        },
      );

      group(
        '.getCachedMessages()',
        () {
          test(
            ' Should return a MessageModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const modelMap = [
                {
                  "uid": "uid",
                  "auxUID": "auxUID",
                  "body": "body",
                  "source": "source",
                  "type": "type",
                  "entityType": "entityType",
                  "applicationUID": "applicationUID",
                }
              ];

              const expectedData = [
                MessageModel(
                  uid: "uid",
                  auxUID: "auxUID",
                  body: "body",
                  source: "source",
                  type: "type",
                  entityType: "entityType",
                  applicationUID: "applicationUID",
                ),
              ];

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => jsonEncode(modelMap));

              final result =
                  await sut.getCachedMessages(memberUID: 'memberUID');

              // Then
              expect(result, expectedData);
            },
          );

          test(
            ' Should return [ if data is null ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);

              // When
              when(authService.sub).thenReturn('sub');
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => null);

              final result =
                  await sut.getCachedMessages(memberUID: 'memberUID');

              // Then
              expect(result, []);
            },
          );
        },
      );

      group(
        '.createMessage()',
        () {
          test(
            ' Should return a MessageModel  ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(data: {
                "uid": "uid",
                "auxUID": "auxUID",
                "body": "body",
                "source": "source",
                "type": "type",
                "entityType": "entityType",
                "applicationUID": "applicationUID",
              });

              const expectedData = MessageModel(
                uid: "uid",
                auxUID: "auxUID",
                body: "body",
                source: "source",
                type: "type",
                entityType: "entityType",
                applicationUID: "applicationUID",
              );

              // When
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => model);

              final result = await sut.createMessage(
                accountUID: 'accountUID',
                channelUID: 'channelUID',
                message: 'message',
              );

              // Then
              expect(result, expectedData);
            },
          );
        },
      );

      group(
        '.deleteChannels()',
        () {
          test(
            ' Should return an UnimplementedError ',
            () {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              List<String> uuids = [];

              // When, Then
              expect(() => sut.deleteChannels(uuids),
                  throwsA(isA<UnimplementedError>()));
            },
          );
        },
      );

      group(
        '.markAsArchived()',
        () {
          test(
            ' Should return an UnimplementedError ',
            () {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              List<String> uuids = [];

              // When, Then
              expect(() => sut.markAsArchived(uuids, true),
                  throwsA(isA<UnimplementedError>()));
            },
          );
        },
      );

      group(
        '.markAsFavorite()',
        () {
          test(
            ' Should return an UnimplementedError ',
            () {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              List<String> uuids = [];

              // When, Then
              expect(() => sut.markAsFavorite(uuids, true),
                  throwsA(isA<UnimplementedError>()));
            },
          );
        },
      );

      group(
        '.deleteMessages()',
        () {
          test(
            ' Should return an UnimplementedError ',
            () {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              List<String> uuids = [];

              // When, Then
              expect(() => sut.deleteMessages(uuids),
                  throwsA(isA<UnimplementedError>()));
            },
          );
        },
      );

      group(
        '.getChannelByUid()',
        () {
          test(
            ' Should return a MessageChannelModel ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(data: {
                'uid': 'uid',
                'displayName': 'displayName',
                'entityType': 'entityType',
                'type': 'type',
                'accountUID': 'accountUID',
              });

              const expectedData = MessageChannelModel(
                uid: 'uid',
                displayName: 'displayName',
                entityType: 'entityType',
                type: 'type',
                accountUID: 'accountUID',
              );

              // When
              when(authService.accountUid).thenReturn('accountUid');
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => model);

              final result = await sut.getChannelByUid('uid');

              // Then
              expect(result, expectedData);
            },
          );

          test(
            ' Should return null if an error parsing occurs ',
            () async {
              // Given
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              const model = HttpResponseModel(data: 'String');

              // When
              when(authService.accountUid).thenReturn('accountUid');
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((_) async => model);

              final result = await sut.getChannelByUid('uid');

              // Then
              expect(result, isNull);
            },
          );
        },
      );

      group(
        '.streamChannelByUid()',
        () {
          test(
            ' Should return a MessageChannelModel ',
            () async {
              // Given
              MessageChannelModel? result;
              String baseURL = 'www.123.co';
              final sut = MessagingServiceImpl(baseURL: baseURL);
              final streamController = StreamController<MessageChannelModel>();
              const model = HttpResponseModel(data: {
                'uid': 'uid',
                'displayName': 'displayName',
              });
              const channelModel = MessageChannelModel(accountUID: '123333');
              const expectedData =
                  MessageChannelModel(uid: 'uid', displayName: 'displayName');
              // When
              when(authService.accountUid).thenReturn('accountUid');
              when(httpService.post(any,
                      headers: anyNamed('headers'), data: anyNamed('data')))
                  .thenAnswer((realInvocation) async => model);
              when(localDatabaseService.read(any, any))
                  .thenAnswer((_) async => channelModel);

              sut.streamChannelByUid('uid').listen((event) {
                result = event;
              });

              streamController.add(channelModel);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(result, expectedData);
            },
          );
        },
      );
    },
  );
}
