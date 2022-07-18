import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_form/reply_form.dart';
import 'package:truvideo_enterprise/model/checklist/template/template.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/checklist/index.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';

import 'checklist_test.mocks.dart';

@GenerateMocks([
  AuthService,
  ConnectivityService,
  HttpService,
])
void main() {
  setUp(
    () async => await GetIt.I.reset(),
  );
  group(
    'ChecklistServiceImplTests',
    () {
      late MockAuthService authService;
      late MockConnectivityService connectivityService;
      late MockHttpService httpService;

      setUp(() {
        authService = MockAuthService();
        connectivityService = MockConnectivityService();
        httpService = MockHttpService();

        GetIt.I.registerSingleton<AuthService>(authService);
        GetIt.I.registerSingleton<ConnectivityService>(connectivityService);
        GetIt.I.registerSingleton<HttpService>(httpService);

        when(authService.accountUid).thenReturn('bar');
        when(authService.token).thenReturn('cod');
      });
      test(
        'Should be initialized',
        () {
          // Given
          final sut = ChecklistServiceImpl(
            baseURL: 'https://httpbin.org/',
            securityToken: 'foo',
          );

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<ChecklistServiceImpl>());
        },
      );

      group(
        '.getTemplates()',
        () {
          test(
            'Should throw a exception if is offline',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.getTemplates(),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that get parameters are correct',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              final tempalte = Template(
                uid: 'uid',
                accountUID: 'accountUID',
                category: 'category',
                createdAt: 'createdAt',
                description: 'description',
                subCategory: 'subCategory',
                templateName: 'templateName',
                templateStatus: 'templateStatus',
                updatedAt: 'updatedAt',
                version: 'version',
              );

              // When
              when(httpService.get(any, headers: anyNamed('headers')))
                  .thenAnswer(
                (_) async => HttpResponseModel(
                  data: {
                    'templates': [tempalte.toJson()],
                  },
                ),
              );

              await sut.getTemplates();

              final captured = verify(httpService.get(
                captureAny,
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(
                captured[0].toString(),
                contains(
                  'CHECKLIST&subCategory=AUTOMOTIVE&templateStatus=PUBLISHED',
                ),
              );
              expect(
                captured[1]['X-Authorization-TruVideo'],
                equals('cod'),
              );
            },
          );
        },
      );

      group(
        '.getTemplateByUID()',
        () {
          test(
            'Should return a exception if is offline',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'cod',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.getTemplateByUID('bar'),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that the get parameters are corrects',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: '',
              );
              final template = Template(
                uid: 'uid',
                accountUID: 'accountUID',
                category: 'category',
                createdAt: 'createdAt',
                description: 'description',
                subCategory: 'subCategory',
                templateName: 'templateName',
                templateStatus: 'templateStatus',
                updatedAt: 'updatedAt',
                version: 'version',
              );

              // When
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => HttpResponseModel(
                  data: {
                    'template': template.toJson(),
                  },
                ),
              );
              await sut.getTemplateByUID('bar');

              final captured = verify(httpService.get(
                captureAny,
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(), contains('https://httpbin.org/'));
              expect(captured[1]['X-Authorization-TruVideo'], equals('cod'));
            },
          );
        },
      );

      group(
        '.saveTemplateReply()',
        () {
          test(
            'Should return a exception when is offline',
            () {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.saveTemplateReply('data'),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that the post parameters are correct',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: {'replyUID': 'replyUID'},
                ),
              );

              await sut.saveTemplateReply('data');

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(), contains('/replies'));
              expect(captured[1], equals('data'));
              expect(captured[2]['X-Authorization-TruVideo'], equals('cod'));
            },
          );
        },
      );

      group(
        '.updateTemplateReply()',
        () {
          test(
            'Should throw exception when is offline',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.updateTemplateReply('foo', 'data'),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that the put parameters are corrects',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const templateUID = 'templateUID';

              // When
              when(httpService.put(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(),
              );

              await sut.updateTemplateReply(templateUID, 'data');

              final captured = verify(httpService.put(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(), contains('/replies/$templateUID'));
              expect(captured[1], equals('data'));
              expect(captured[2]['X-Authorization-TruVideo'], equals('cod'));
            },
          );

          test(
            'Should return a string of HttpResponseModel',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const expecteData = HttpResponseModel(
                message: 'Request success',
                statusCode: 400,
              );
              // When
              when(httpService.put(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(
                  message: 'Request success',
                  statusCode: 400,
                ),
              );

              final response =
                  await sut.updateTemplateReply('templateUID', 'data');

              // Then
              expect(response, equals(expecteData.toString()));
            },
          );
        },
      );

      group(
        '.getTemplateReplyByEntity()',
        () {
          test(
            'Should throw exception when is offline',
            () {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.getTemplateReplyByEntity('jobServiceNumber'),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that the get parameters are corrects',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const jobServiceNumber = 'foo';
              const replyForm = ReplyForm(
                accountUID: 'accountUID',
                assigneeUID: 'assigneeUID',
                createdAt: 'createdAt',
                entityType: 'entityType',
                entityUID: 'entityUID',
                replyStatus: 'replyStatus',
                templateUID: 'templateUID',
                templateVersion: 'templateVersion',
                uid: 'uid',
                updatedAt: 'updatedAt',
                visibleFor: 'visibleFor',
              );

              // When
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => HttpResponseModel(
                  data: {
                    'replies': [
                      replyForm.toJson(),
                    ],
                  },
                ),
              );

              await sut.getTemplateReplyByEntity(jobServiceNumber);

              final captured = verify(httpService.get(
                captureAny,
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/replies/entities/REPAIR_ORDER/$jobServiceNumber'),
              );
              expect(captured[1]['X-Authorization-TruVideo'], equals('cod'));
            },
          );

          test(
            'Should return a list of ReplyForm',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const jobServiceNumber = 'foo';
              const replyForm = ReplyForm(
                accountUID: 'accountUID',
                assigneeUID: 'assigneeUID',
                createdAt: 'createdAt',
                entityType: 'entityType',
                entityUID: 'entityUID',
                replyStatus: 'replyStatus',
                templateUID: 'templateUID',
                templateVersion: 'templateVersion',
                uid: 'uid',
                updatedAt: 'updatedAt',
                visibleFor: 'visibleFor',
                replies: [],
              );

              // When
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => HttpResponseModel(
                  data: {
                    'replies': [
                      replyForm.toJson(),
                    ],
                  },
                ),
              );

              final response =
                  await sut.getTemplateReplyByEntity(jobServiceNumber);

              // Then
              expect(response, equals([replyForm]));
            },
          );
        },
      );

      group(
        '.getTemplateReplyByReplyID()',
        () {
          test(
            'Should throw exception when is offline',
            () {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              // Then
              expect(
                () async => sut.getTemplateReplyByReplyID('replyID'),
                throwsA(
                  isA<CustomException>(),
                ),
              );
            },
          );

          test(
            'Check that the get parameters are corrects',
            () async {
              // Given
              final sut = ChecklistServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const replyID = 'foo';

              // When
              when(httpService.get(
                any,
                headers: anyNamed('headers'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(data: {
                  'reply': {
                    'accountUID': 'accountUID',
                    'assigneeUID': 'assigneeUID',
                    'createdAt': 'createdAt',
                    'entityType': 'entityType',
                    'entityUID': 'entityUID',
                    'replyStatus': 'replyStatus',
                    'templateUID': 'templateUID',
                    'templateVersion': 'templateVersion',
                    'uid': 'uid',
                    'updatedAt': 'updatedAt',
                    'visibleFor': 'visibleFor'
                  },
                  'template': {
                    'uid': 'uid',
                    'accountUID': 'accountUID',
                    'category': 'category',
                    'createdAt': 'createdAt',
                    'description': 'description',
                    'subCategory': 'subCategory',
                    'templateName': 'templateName',
                    'templateStatus': 'templateStatus',
                    'updatedAt': 'updatedAt',
                    'version': 'version'
                  }
                }),
              );

              await sut.getTemplateReplyByReplyID(replyID);

              final captured = verify(httpService.get(
                captureAny,
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/replies/$replyID'),
              );
              expect(captured[1]['X-Authorization-TruVideo'], equals('cod'));
            },
          );
        },
      );
    },
  );
}
