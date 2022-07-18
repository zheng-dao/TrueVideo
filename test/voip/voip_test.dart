import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/model/message_call_participant.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/device/index.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/voip/index.dart';

import 'voip_test.mocks.dart';

@GenerateMocks([
  AuthService,
  HttpService,
])
main() {
  setUp(() async {
    await GetIt.I.reset();
  });
  group(
    '.VoipServiceImplTests',
    () {
      late MockAuthService authService;
      late MockHttpService httpService;

      setUp(() {
        authService = MockAuthService();
        httpService = MockHttpService();

        GetIt.I.registerSingleton<AuthService>(authService);
        GetIt.I.registerSingleton<HttpService>(httpService);

        when(authService.token).thenReturn('foo');
      });
      test(
        'Should be initialized',
        () {
          // Given
          final sut = VoipServiceImpl(baseURL: 'https://httpbin.org/');

          // When, Then
          expect(sut, isNotNull);
          expect(sut, isA<VoipServiceImpl>());
        },
      );

      group(
        '.register()',
        () {
          test(
            'Check that the post parameters are correct',
            () async {
              // Given
              final platformInfo = PlatformInfo(
                isAndroid: false,
                isIOS: true,
                isWeb: false,
              );
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
                platformInfo: platformInfo,
              );

              // When
              when(authService.token).thenReturn('foo');
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel(
                    data: {
                      'identity': 'identity',
                      'token': 'token',
                    },
                  ));

              await sut.register(uid: 'cod', accountUID: 'bar');

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(), contains('/api/voip/token'));
              expect(captured[1]['accountUID'], equals('bar'));
              expect(captured[1]['messageableEntityUID'], equals('cod'));
              expect(captured[1]['deviceType'], equals('Iphone'));
              expect(captured[2]['x-authorization-truvideo'], equals('foo'));
            },
          );

          test(
            'Should return null in case of error',
            () async {
              // Given
              final platformInfo = PlatformInfo(
                isAndroid: false,
                isIOS: true,
                isWeb: false,
              );
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
                platformInfo: platformInfo,
              );

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer(
                  (realInvocation) async => const HttpResponseModel());

              final response =
                  await sut.register(uid: 'cod', accountUID: 'bar');

              // Then
              expect(response, isNull);
            },
          );
        },
      );

      group(
        '.getParticipants()',
        () {
          test(
            'Check that the post parameters are correct',
            () async {
              // Given
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
              );

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel(
                    data: [
                      {
                        'callSid': 'callSid',
                        'conferenceSid': 'conferenceSid',
                        'messageableEntityUID': 'messageableEntityUID',
                        'messageableEntityDisplayName':
                            'messageableEntityDisplayName',
                        'status': 'status',
                        'hold': true,
                        'muted': false,
                      },
                    ],
                  ));

              await sut.getParticipants(
                channelUID: 'bar',
                accountUID: 'cod',
              );

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(),
                  contains('/api/voip/getConferenceParticipants'));
              expect(captured[1]['accountUID'], equals('cod'));
              expect(captured[1]['channelUID'], equals('bar'));
              expect(captured[2]['x-authorization-truvideo'], equals('foo'));
              expect(captured[2]['channelUID'], equals('bar'));
            },
          );

          test(
            'Should return empty in case of parsing error',
            () async {
              // Given
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
              );
              const data = [
                MessageCallParticipantModel(
                  callSid: 'callSid',
                  conferenceSid: 'conferenceSid',
                  createdAt: null,
                  hold: true,
                  messageableEntityDisplayName: 'messageableEntityDisplayName',
                  messageableEntityUID: 'messageableEntityUID',
                  muted: false,
                  status: 'status',
                )
              ];

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel(data: data));

              final response = await sut.getParticipants(
                channelUID: 'bar',
                accountUID: 'cod',
              );

              // Then
              expect(response, isEmpty);
            },
          );
        },
      );

      group(
        '.muteParticipant()',
        () {
          test(
            'Check that the post parameters are correct',
            () async {
              // Given
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
              );

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel());

              await sut.muteParticipant(
                channelUID: 'bar',
                accountUID: 'cod',
                participantCallSID: 'clash',
                muted: true,
              );

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(),
                  contains('/api/voip/updateConferenceParticipant'));
              expect(captured[1]['accountUID'], equals('cod'));
              expect(captured[1]['channelUID'], equals('bar'));
              expect(captured[1]['participantCallSID'], equals('clash'));
              expect(captured[1]['muted'], equals(true));
              expect(captured[2]['x-authorization-truvideo'], equals('foo'));
              expect(captured[2]['channelUID'], equals('bar'));
            },
          );
        },
      );

      group(
        '.updateConferenceStatus()',
        () {
          test(
            'Check that the post parameters are correct',
            () async {
              // Given
              final sut = VoipServiceImpl(
                baseURL: 'https://httpbin.org/',
              );

              // When
              when(httpService.post(
                any,
                data: anyNamed('data'),
                headers: anyNamed('headers'),
              )).thenAnswer((_) async => const HttpResponseModel());

              await Future.delayed(const Duration(seconds: 1), () => {});

              await sut.updateConferenceStatus(
                  channelUID: 'bar', accountUID: 'cod');

              final captured = verify(httpService.post(
                captureAny,
                data: captureAnyNamed('data'),
                headers: captureAnyNamed('headers'),
              )).captured;

              // Then
              expect(captured[0].toString(),
                  contains('/updateConferenceStatus'));
              expect(captured[1]['accountUID'], equals('cod'));
              expect(captured[1]['channelUID'], equals('bar'));
              expect(captured[2]['x-authorization-truvideo'], equals('foo'));
              expect(captured[2]['channelUID'], equals('bar'));
            },
          );
        },
      );
    },
  );
}
