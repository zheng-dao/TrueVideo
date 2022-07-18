import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/dealer_code_access_history.dart';
import 'package:truvideo_enterprise/model/device_info.dart';
import 'package:truvideo_enterprise/model/user.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/service/auth/index.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/local/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/push_notification/_interface.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';

import 'auth_test.mocks.dart';

extension AuthenticatedResponse on HttpResponseModel {
  /// Returns an Authenticated [HttpResponseModel] including the authorization
  /// header.
  static HttpResponseModel create() {
    return const HttpResponseModel(
      headers: {
        'x-authorization-truvideo': ['bar'],
      },
    );
  }
}

@GenerateMocks([
  ConnectivityService,
  DeviceService,
  HttpService,
  LocalDatabaseService,
  LocalService,
  PushNotificationService,
])
main() {
  setUp(() async {
    await GetIt.I.reset();
  });

  group(
    "AuthTests",
    () {
      late MockConnectivityService connectivityService;
      late DeviceInfoModel deviceInfoModel;
      late MockDeviceService deviceService;
      late MockLocalDatabaseService localDatabase;
      late MockLocalService localService;
      late MockPushNotificationService pushService;
      late MockHttpService service;
      late RequestOptions requestOptions;
      

      setUp(() {
        connectivityService = MockConnectivityService();
        deviceService = MockDeviceService();
        localDatabase = MockLocalDatabaseService();
        localService = MockLocalService();
        pushService = MockPushNotificationService();
        service = MockHttpService();
        deviceInfoModel = const DeviceInfoModel(
          id: "id",
          manufacturer: "manufacturer",
          model: "model",
          name: "name",
        );
        requestOptions = RequestOptions(path: "/foo");

        GetIt.I.registerSingleton<ConnectivityService>(connectivityService);
        GetIt.I.registerSingleton<DeviceService>(deviceService);
        GetIt.I.registerSingleton<LocalDatabaseService>(localDatabase);
        GetIt.I.registerSingleton<LocalService>(localService);
        GetIt.I.registerSingleton<PushNotificationService>(pushService);
        GetIt.I.registerSingleton<HttpService>(service);

        when(deviceService.getInfo()).thenAnswer((_) async => deviceInfoModel);
        when(pushService.getToken()).thenAnswer((_) async => "token");
      });

      test(
        'Should be initialized',
        () {
          // Given
          final sut = AuthServiceImpl(
            baseURL: "https://httpbin.org/",
            securityToken: "foo",
          );

          // When, Then
          expect(sut, isA<AuthServiceImpl>());
        },
      );

      group(
        '.getCachedLoggedUser()',
        () {
          test(
            'Should return null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                localDatabase.read(any, any),
              ).thenAnswer((_) async => '');


              when(localService.readString(any)).thenAnswer((_) => 'foo');

              final result = await sut.getCachedLoggedUser();

              // Then
              expect(result, isNull);
            },
          );

          test(
            'Should return a user in case of success',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const user = UserModel(
                publicUserUuid: '1234',
                emailAddress: 'emailAddress',
                firstName: 'firstName',
                lastName: 'lastName',
                role: 'role',
                title: 'title',
              );

              // When
              when(
                localDatabase.read(any, any),
              ).thenAnswer((_) async => user);

              when(localService.readString(any)).thenAnswer((_) => 'foo');

              final result = await sut.getCachedLoggedUser();

              // Then
              expect(result, equals(user));
            },
          );

          test(
            'Should return null in case of error',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                localDatabase.read(any, any),
              ).thenAnswer((_) async => String);

              when(localService.readString(any)).thenAnswer((_) => 'foo');

              final result = await sut.getCachedLoggedUser();

              // Then
              expect(result, isNull);
            },
          );
        },
      );

      group(
        ".login()",
        () {
          test(
            'should return false when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.login(
                  dealerCode: '123456',
                  userUuid: 'foo',
                  pin: '123',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
          test(
            "applies parameters to the service",
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: "foo",
              );
              const expectedData = {
                "deviceId": "id",
                "manufacturer": "manufacturer",
                "model": "model",
                "name": "name",
                "latitude": 0,
                "longitude": 0,
                "dealerCode": "123456",
                "userUuid": "foo",
                "pin": "123",
                "token": "token",
              };

              // When
              when(
                service.post(
                  Uri.parse('$baseUrl/api/v3/registration/login'),
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.login(
                dealerCode: "123456",
                userUuid: "foo",
                pin: "123",
              );

              final captured = verify(
                service.post(
                  captureAny,
                  data: captureAnyNamed('data'),
                  headers: captureAnyNamed("headers"),
                ),
              ).captured;

              // Then
              expect(captured[1], equals(expectedData));
              expect(captured[2]['X-security-token'], equals('foo'));
            },
          );

          test(
            "should store authorization token",
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.login(
                dealerCode: "123456",
                userUuid: "foo",
                pin: "123",
              );

              // Then
              expect(
                verify(localService.storeString(captureAny, captureAny))
                    .captured
                    .last,
                equals("bar"),
              );
            },
          );

          test(
            'should store uuid',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer(
                (_) async {
                  return AuthenticatedResponse.create();
                },
              );

              await sut.login(
                dealerCode: "123456",
                userUuid: "foo",
                pin: "123",
              );

              // Then
              verify(
                localService.storeString(captureAny, captureAny),
              ).called(2);
            },
          );

          test(
            'should be a success',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              final loginResult = await sut.login(
                dealerCode: "123456",
                userUuid: "fo",
                pin: "123",
              );

              // Then
              expect(loginResult, LoginResult.success);
            },
          );

          test(
            'should fail for a invalid pin',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                    data: {'message': 'Invalid Pin'},
                  ),
                ),
              );

              final loginResult = await sut.login(
                dealerCode: "123456",
                userUuid: "fo",
                pin: "123",
              );

              // Then
              expect(loginResult, LoginResult.invalidPin);
            },
          );

          test(
            'should throw a customException for a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                    data: {'message': 'Invalid Pin '},
                  ),
                ),
              );

              // Then
              expect(
                  () async => sut.login(
                        dealerCode: "123456",
                        userUuid: "fo",
                        pin: "123",
                      ),
                  throwsA(isA<CustomException>()));
            },
          );

          test(
            'should fail with a DioEErort on 404',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.login(
                  dealerCode: '123456',
                  userUuid: 'fo',
                  pin: '123',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<DioError>());
            },
          );

          test(
            'should fail with a DioError on unhandled status code',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 500,
                  ),
                ),
              );

              try {
                await sut.login(
                  dealerCode: '123456',
                  userUuid: 'fo',
                  pin: '123',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<DioError>());
            },
          );

          test(
            'should fail with an unauthorized',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 401,
                  ),
                ),
              );

              final loginResult = await sut.login(
                dealerCode: "123456",
                userUuid: "fo",
                pin: "123",
              );

              // Then
              expect(loginResult, LoginResult.unauthorized);
            },
          );

          test(
            'should fail with an user not found',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 404,
                    data: {'message': "User not found"},
                  ),
                ),
              );

              final loginResult = await sut.login(
                dealerCode: "123456",
                userUuid: "fo",
                pin: "123",
              );

              // Then
              expect(loginResult, LoginResult.userNotFound);
            },
          );

          test(
            'should throw a customException for a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 404,
                    data: {'message': "User not found "},
                  ),
                ),
              );

              // Then
              expect(
                  () async => sut.login(
                        dealerCode: "123456",
                        userUuid: "fo",
                        pin: "123",
                      ),
                  throwsA(isA<CustomException>()));
            },
          );

          test(
            "should throw error if header is null",
            () async {
              // Given
              Object? error;
              const expected = 'No header response. Header response: null';
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(),
              );

              try {
                await sut.login(
                    dealerCode: "123456", userUuid: "foo", pin: "123");
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
              expect(error.toString(), equals(expected));
            },
          );

          test(
            "should throw error if no response header key",
            () async {
              // Given
              Object? error;
              const expectedMessage = 'No response header key: '
                  '\'x-authorization-truvideo\'. Header '
                  'response: {}';

              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer((_) async => const HttpResponseModel(headers: {}));

              try {
                await sut.login(
                  dealerCode: "123456",
                  userUuid: "foo",
                  pin: "123",
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
              expect(error.toString(), equals(expectedMessage));
            },
          );

          test(
            "login should throw error if header is empty",
            () async {
              // Given
              Object? error;
              const expected = 'Response header \'x-authorization-truvideo\' '
                  'is empty. Header response: {x-authorization-truvideo: []}';
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  headers: {'x-authorization-truvideo': []},
                ),
              );

              try {
                await sut.login(
                  dealerCode: "123456",
                  userUuid: "foo",
                  pin: "123",
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
              expect(error.toString(), equals(expected));
            },
          );

          test(
            "should throw error if header value is empty",
            () async {
              // Given
              Object? error;
              const expected = 'Response header \'x-authorization-truvideo\' '
                  'value is empty. Header response: {x-authorization-truvideo: []}';
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(
                service.post(
                  any,
                  data: anyNamed("data"),
                  headers: anyNamed("headers"),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  headers: {
                    'x-authorization-truvideo': [''],
                  },
                ),
              );

              try {
                await sut.login(
                  dealerCode: "123456",
                  userUuid: "foo",
                  pin: "123",
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
              expect(error.toString(), equals(expected));
            },
          );
        },
      );

      group(
        '.isLogin()',
        () {
          test(
            'should return null if token is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              final isLogin = await sut.isLogin();

              // Then
              expect(isLogin, isNull);
            },
          );

          test(
            'should return null if token have a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: "https://httpbin.org/",
                securityToken: "foo",
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => ' ');

              final isLogin = await sut.isLogin();

              // Then
              expect(isLogin, isNull);
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const token =
                  'eyJhbGciOiJIUzUxMiJ9.eyJhcHBsaWNhdGlvblVpZCI6Ijk4Y2FjNDR'
                  'jLWE5YmQtNDgwNy1hOWQ1LTNmMzU5ZjE4ZTA4YSIsImFjY291bnRVaWQiOiI0MSIsInNlc3'
                  'Npb25UeXBlIjoiQVBJX0tFWV9TRUNSRVQiLCJkZXZpY2VVaWQiOiI5MTE3NTlERS0zNTdCL'
                  'TQ3OEYtODQ5QS02NjUwMUQxMEFCRUIiLCJkaXNwbGF5TmFtZSI6IlBhYmxvIDExIERpb25pI'
                  'iwic3ViIjoiMzA3NiIsImlhdCI6MTY0OTM2MzAyMiwiZ3JvdXBzIjoiU2VydmljZSBBcHAiL'
                  'CJleHAiOjE2NDk4MTMwMjJ9.fl2Ezj_-N9pVozaHEHHdTCqhIxiVC2950kcrHu9niaQZXB5Xk'
                  'wQlqn1146rlhfRuCSoSnQJbse_y13UqXrAZmg';
              const baseUrl = 'https://httpbin.org';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => token);
              when(pushService.getToken()).thenAnswer((_) async => 'bar');

              when(connectivityService.validateOnline())
                  .thenAnswer((_) async {});

              when(
                service.get(Uri.parse('$baseUrl/api/v3/registration/login'),
                    headers: anyNamed('headers'), params: anyNamed('params')),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.isLogin();

              // Then
              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              expect(
                captured[0].toString(),
                contains('/api/v3/registration/login'),
              );
              expect(captured[1]['X-Authorization-Truvideo'], equals(token));
              expect(captured[1]['X-Authorization-fcm'], equals('bar'));
              expect(captured[2]['account-uid'], equals('41'));
            },
          );

          test(
            'should return user in case of success',
            () async {
              // Given
              const token =
                  'eyJhbGciOiJIUzUxMiJ9.eyJhcHBsaWNhdGlvblVpZCI6Ijk4Y2FjNDR'
                  'jLWE5YmQtNDgwNy1hOWQ1LTNmMzU5ZjE4ZTA4YSIsImFjY291bnRVaWQiOiI0MSIsInNlc3'
                  'Npb25UeXBlIjoiQVBJX0tFWV9TRUNSRVQiLCJkZXZpY2VVaWQiOiI5MTE3NTlERS0zNTdCL'
                  'TQ3OEYtODQ5QS02NjUwMUQxMEFCRUIiLCJkaXNwbGF5TmFtZSI6IlBhYmxvIDExIERpb25pI'
                  'iwic3ViIjoiMzA3NiIsImlhdCI6MTY0OTM2MzAyMiwiZ3JvdXBzIjoiU2VydmljZSBBcHAiL'
                  'CJleHAiOjE2NDk4MTMwMjJ9.fl2Ezj_-N9pVozaHEHHdTCqhIxiVC2950kcrHu9niaQZXB5Xk'
                  'wQlqn1146rlhfRuCSoSnQJbse_y13UqXrAZmg';
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );
              const user = UserModel(
                publicUserUuid: '1234',
                emailAddress: 'emailAddress',
                firstName: 'firstName',
                lastName: 'lastName',
                role: 'role',
                title: 'title',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => token);
              when(pushService.getToken()).thenAnswer((_) async => 'bar');

              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => HttpResponseModel(
                    headers: {
                      'X-Authorization-Truvideo': ['token'],
                    },
                    data: user.toJson(),
                  ));

              final result = await sut.isLogin();

              // Then
              expect(result, equals(user));
            },
          );

          test(
            'should return null if user is null',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(pushService.getToken()).thenAnswer((_) async => 'bar');

              when(
                service.get(any, headers: anyNamed('headers')),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              when(
                service.get(any, headers: anyNamed('headers')),
              ).thenAnswer(
                (_) async => const HttpResponseModel(headers: {
                  'X-Authorization-Truvideo': ['token'],
                }, data: String),
              );
              final result = await sut.isLogin();

              // Then
              expect(result, isNull);
            },
          );

          test(
            'should return null on error',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(pushService.getToken()).thenAnswer((_) async => 'bar');

              when(connectivityService.validateOnline())
                  .thenAnswer((_) async {});

              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/login'),
                  headers: anyNamed('headers'),
                ),
              ).thenThrow(() => CustomException());

              final result = await sut.isLogin();

              // Then
              expect(result, null);
            },
          );
        },
      );

      group(
        '.getLastAccessDate()',
        () {
          test(
            'should return null if date is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return null if date have a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => ' ');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return a DateTime',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any))
                  .thenAnswer((_) => DateTime.now().toString());

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isA<DateTime>());
            },
          );

          test(
            'should return a null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(localService.delete(any)).thenAnswer((_) async => {});

              final result = sut.getLastAccessDate('foo');

              // Then
              expect(result, isNull);
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteLastAccessDate()',
        () {
          test(
            'verify if localService is called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              //When
              when(localService.delete(any)).thenAnswer((_) async => {});

              await sut.deleteLastAccessDate('foo');

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.logout()',
        () {
          test(
            'Validate correct parameters',
            () async {
              // Given
              const token =
                  'eyJhbGciOiJIUzUxMiJ9.eyJhcHBsaWNhdGlvblVpZCI6Ijk4Y2FjNDR'
                  'jLWE5YmQtNDgwNy1hOWQ1LTNmMzU5ZjE4ZTA4YSIsImFjY291bnRVaWQiOiI0MSIsInNlc3'
                  'Npb25UeXBlIjoiQVBJX0tFWV9TRUNSRVQiLCJkZXZpY2VVaWQiOiI5MTE3NTlERS0zNTdCL'
                  'TQ3OEYtODQ5QS02NjUwMUQxMEFCRUIiLCJkaXNwbGF5TmFtZSI6IlBhYmxvIDExIERpb25pI'
                  'iwic3ViIjoiMzA3NiIsImlhdCI6MTY0OTM2MzAyMiwiZ3JvdXBzIjoiU2VydmljZSBBcHAiL'
                  'CJleHAiOjE2NDk4MTMwMjJ9.fl2Ezj_-N9pVozaHEHHdTCqhIxiVC2950kcrHu9niaQZXB5Xk'
                  'wQlqn1146rlhfRuCSoSnQJbse_y13UqXrAZmg';
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => token);

              when(localService.delete(any)).thenAnswer((_) async => {});

              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/logout'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.logout();

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              verify(localService.delete(any)).called(1);
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/logout'),
              );
              expect(captured[1]['X-Authorization-Truvideo'], equals(token));
              verify(pushService.revokeToken()).called(1);
            },
          );

          test(
            'Should return if token is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              // Then
              verifyNever(localService.delete(any));
              verifyNever(service.get(
                captureAny,
                headers: captureAnyNamed(
                  'headers',
                ),
              ));
            },
          );
        },
      );

      group(
        '.getDealerInfo()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const data = {
                'publicDealerUuid': '123456',
                'dealerCodeType': '742',
                'name': 'user1',
              };

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/verify-dealer'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async {
                return const HttpResponseModel(data: data);
              });

              final dealerInfo = await sut.getDealerInfo('info');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/verify-dealer'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('info'));
              expect(dealerInfo?.publicDealerUuid, equals('123456'));
              expect(dealerInfo?.dealerCodeType, equals('742'));
              expect(dealerInfo?.name, equals('user1'));
            },
          );

          test(
            'should return null if there a error of response',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(DioError(
                requestOptions: requestOptions,
                response: Response(
                  requestOptions: requestOptions,
                  statusCode: 404,
                ),
              ));

              final result = await sut.getDealerInfo('info');

              // Then
              expect(result, null);
            },
          );

          test(
            'should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getUsersForDealerCode()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123456');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/users'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: [
                    {
                      'publicUserUuid': 'publicUserUuid',
                      'completeName': 'completeName',
                    }
                  ],
                ),
              );

              final userLoginModel = await sut.getUsersForDealerCode('123');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/users'),
              );
              expect(userLoginModel, isNotEmpty);
            },
          );

          test(
            'Should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.storeDealerCode()',
        () {
          test(
            'should store dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.storeString(any, any))
                  .thenAnswer((_) async => '123456');

              when(localDatabase.write(any, any, any)).thenAnswer(
                  (_) async => const DealerCodeAccessHistoryModel());

              await sut.storeDealerCode('123456');

              final captured = verify(
                localDatabase.write(
                  captureAny,
                  captureAny,
                  captureAny,
                ),
              ).captured;

              // Then
              verify(
                localService.storeString(
                  captureAny,
                  captureAny,
                ),
              ).called(1);

              expect(captured[0], equals('dealer-codes'));
              expect(captured[1], equals('123456'));
              expect(captured[2]['date'], isNotEmpty);
              expect(captured[2]['dealerCode'], equals('123456'));
            },
          );
        },
      );

      group(
        '.clearDealerCode()',
        () {
          test(
            'Should delete dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.delete(any)).thenAnswer((_) async => {});

              sut.clearDealerCode();

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getStoredDealerCode()',
        () {
          test(
            'Should read dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.readString(any))
                  .thenAnswer((_) => 'dealer-code');

              final result = sut.getStoredDealerCode();

              // Then
              expect(result, 'dealer-code');
            },
          );
        },
      );

      group(
        '.create()',
        () {
          test(
            'should throw exception when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'IntegrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'userName',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'Validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const expectedData = {
                'firstName': 'firstName',
                'lastName': 'lastName',
                'pin': '0000',
                'title': 'title',
                'publicDealerUuid': 'publicDealerUuid',
                'email': 'email',
                'username': 'username',
                'password': '1111',
                'mobileNumber': 'mobileNumber',
                'isPasswordEncoded': false,
                'integrationId': 'integrationId',
              };

              const data = {
                'publicUserUuid': 'publicUserUuid',
                'completeName': 'completeName',
              };

              // When
              when(
                service.post(
                  Uri.parse('$baseUrl/api/v3/registration/register-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenAnswer((_) async => const HttpResponseModel(data: data));

              final userLoginModel = await sut.create(
                dealerCode: '123456',
                publicDealerUuid: 'publicDealerUuid',
                integrationId: 'integrationId',
                mobileNumber: 'mobileNumber',
                firstName: 'firstName',
                lastName: 'lastName',
                title: 'title',
                email: 'email',
                username: 'username',
                password: '1111',
                pin: '0000',
              );

              final captured = verify(
                service.post(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                  data: captureAnyNamed('data'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/register-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('123456'));
              expect(captured[3], equals(expectedData));
              expect(userLoginModel.publicUserUuid, equals('publicUserUuid'));
              expect(userLoginModel.completeName, equals('completeName'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.streamDealerCodesHistory()',
        () {
          test(
            'StreamAll should be called',
            () async {
              // Given
              List<DealerCodeAccessHistoryModel> results = [];
              final streamController =
                  StreamController<List<DealerCodeAccessHistoryModel>>();
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const dealerCodes = [
                DealerCodeAccessHistoryModel(dealerCode: 'dealer-codes'),
                DealerCodeAccessHistoryModel(dealerCode: 'dealer'),
                DealerCodeAccessHistoryModel(dealerCode: 'codes'),
                DealerCodeAccessHistoryModel(dealerCode: 'dealer-code'),
              ];

              // When
              when(
                localDatabase.streamAll(any),
              ).thenAnswer(
                (_) => streamController.stream,
              );

              sut.streamDealerCodesHistory().listen((event) {
                results.addAll(event);
              });

              streamController.add(dealerCodes);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, equals(dealerCodes));
            },
          );

          test(
            'Should return empty in case of parsing error',
            () async {
              // Given
              List<DealerCodeAccessHistoryModel> results = [];
              final streamController = StreamController<List<String>>();
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const dealerCodes = ['dealer-codes'];

              // When
              when(
                localDatabase.streamAll(any),
              ).thenAnswer(
                (_) => streamController.stream,
              );

              sut.streamDealerCodesHistory().listen((event) {
                results.addAll(event);
              });

              streamController.add(dealerCodes);

              await Future.delayed(const Duration(seconds: 1), () {
                streamController.close();
              });

              // Then
              expect(results, isEmpty);
            },
          );
        },
      );

      group(
        '.getDealerCodesHistory()',
        () {
          test(
            'getAll should be called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                localDatabase.getAll(any),
              ).thenAnswer((_) async => ['dealer-codes']);

              await sut.getDealerCodesHistory();

              // Then
              verify(localDatabase.getAll(captureAny)).called(1);
            },
          );

          test(
            'Should return a list of DealerCodeAccessHistoryModel',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const dealerCodes = [
                DealerCodeAccessHistoryModel(dealerCode: 'dealer-codes'),
                DealerCodeAccessHistoryModel(dealerCode: 'dealer'),
                DealerCodeAccessHistoryModel(dealerCode: 'codes'),
                DealerCodeAccessHistoryModel(dealerCode: 'dealer-code'),
              ];

              // When
              when(
                localDatabase.getAll(any),
              ).thenAnswer((_) async => dealerCodes);

              final result = await sut.getDealerCodesHistory();

              // Then
              expect(result.length, equals(4));
            },
          );

          test(
            'Should return empty in case of parsing error',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const dealerCode = [];

              // When
              when(
                localDatabase.getAll(any),
              ).thenAnswer((_) async => dealerCode);

              final result = await sut.getDealerCodesHistory();

              // Then
              expect(result, isEmpty);
            },
          );
        },
      );

      group(
        '.validateUsernameEmail()',
        () {
          test(
            'Should exception error when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/check-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.validateUsernameEmail(
                email: 'email',
                username: 'username',
              );

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then

              expect(
                captured[0].toString(),
                contains('/api/v3/registration/check-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['username'], equals('username'));
              expect(captured[2]['email'], equals('email'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getLastAccessDate()',
        () {
          test(
            'should return null if date is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return null if date have a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => ' ');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return a DateTime',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any))
                  .thenAnswer((_) => DateTime.now().toString());

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isA<DateTime>());
            },
          );

          test(
            'should return a null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(localService.delete(any)).thenAnswer((_) async => {});

              final result = sut.getLastAccessDate('foo');

              // Then
              expect(result, isNull);
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteLastAccessDate()',
        () {
          test(
            'verify if localService is called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              //When
              when(localService.delete(any)).thenAnswer((_) async => {});

              await sut.deleteLastAccessDate('foo');

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getDealerInfo()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const data = {
                'publicDealerUuid': '123456',
                'dealerCodeType': '742',
                'name': 'user1',
              };

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/verify-dealer'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async {
                return const HttpResponseModel(data: data);
              });

              final dealerInfo = await sut.getDealerInfo('info');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/verify-dealer'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('info'));
              expect(dealerInfo?.publicDealerUuid, equals('123456'));
              expect(dealerInfo?.dealerCodeType, equals('742'));
              expect(dealerInfo?.name, equals('user1'));
            },
          );

          test(
            'should return null if there a error of response',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(DioError(
                requestOptions: requestOptions,
                response: Response(
                  requestOptions: requestOptions,
                  statusCode: 404,
                ),
              ));

              final result = await sut.getDealerInfo('info');

              // Then
              expect(result, null);
            },
          );

          test(
            'should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getUsersForDealerCode()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123456');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/users'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: [
                    {
                      'publicUserUuid': 'publicUserUuid',
                      'completeName': 'completeName',
                    }
                  ],
                ),
              );

              final userLoginModel = await sut.getUsersForDealerCode('123');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/users'),
              );
              expect(userLoginModel, isNotEmpty);
            },
          );

          test(
            'Should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.storeDealerCode()',
        () {
          test(
            'should store dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.storeString(any, any))
                  .thenAnswer((_) async => '123456');

              when(localDatabase.write(any, any, any)).thenAnswer(
                  (_) async => const DealerCodeAccessHistoryModel());

              await sut.storeDealerCode('123456');

              final captured = verify(
                localDatabase.write(
                  captureAny,
                  captureAny,
                  captureAny,
                ),
              ).captured;

              // Then
              verify(
                localService.storeString(
                  captureAny,
                  captureAny,
                ),
              ).called(1);

              expect(captured[0], equals('dealer-codes'));
              expect(captured[1], equals('123456'));
              expect(captured[2]['date'], isNotEmpty);
              expect(captured[2]['dealerCode'], equals('123456'));
            },
          );
        },
      );

      group(
        '.clearDealerCode()',
        () {
          test(
            'Should delete dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.delete(any)).thenAnswer((_) async => {});

              sut.clearDealerCode();

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getStoredDealerCode()',
        () {
          test(
            'Should read dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.readString(any))
                  .thenAnswer((_) => 'dealer-code');

              final result = sut.getStoredDealerCode();

              // Then
              expect(result, 'dealer-code');
            },
          );
        },
      );

      group(
        '.create()',
        () {
          test(
            'should throw exception when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'IntegrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'userName',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'Validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const expectedData = {
                'firstName': 'firstName',
                'lastName': 'lastName',
                'pin': '0000',
                'title': 'title',
                'publicDealerUuid': 'publicDealerUuid',
                'email': 'email',
                'username': 'username',
                'password': '1111',
                'mobileNumber': 'mobileNumber',
                'isPasswordEncoded': false,
                'integrationId': 'integrationId',
              };

              const data = {
                'publicUserUuid': 'publicUserUuid',
                'completeName': 'completeName',
              };

              // When
              when(
                service.post(
                  Uri.parse('$baseUrl/api/v3/registration/register-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenAnswer((_) async => const HttpResponseModel(data: data));

              final userLoginModel = await sut.create(
                dealerCode: '123456',
                publicDealerUuid: 'publicDealerUuid',
                integrationId: 'integrationId',
                mobileNumber: 'mobileNumber',
                firstName: 'firstName',
                lastName: 'lastName',
                title: 'title',
                email: 'email',
                username: 'username',
                password: '1111',
                pin: '0000',
              );

              final captured = verify(
                service.post(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                  data: captureAnyNamed('data'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/register-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('123456'));
              expect(captured[3], equals(expectedData));
              expect(userLoginModel.publicUserUuid, equals('publicUserUuid'));
              expect(userLoginModel.completeName, equals('completeName'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.validateUsernameEmail()',
        () {
          test(
            'Should exception error when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/check-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.validateUsernameEmail(
                email: 'email',
                username: 'username',
              );

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then

              expect(
                captured[0].toString(),
                contains('/api/v3/registration/check-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['username'], equals('username'));
              expect(captured[2]['email'], equals('email'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getLastAccessDate()',
        () {
          test(
            'should return null if date is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return null if date have a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => ' ');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return a DateTime',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any))
                  .thenAnswer((_) => DateTime.now().toString());

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isA<DateTime>());
            },
          );

          test(
            'should return a null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(localService.delete(any)).thenAnswer((_) async => {});

              final result = sut.getLastAccessDate('foo');

              // Then
              expect(result, isNull);
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteLastAccessDate()',
        () {
          test(
            'verify if localService is called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              //When
              when(localService.delete(any)).thenAnswer((_) async => {});

              await sut.deleteLastAccessDate('foo');

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getDealerInfo()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const data = {
                'publicDealerUuid': '123456',
                'dealerCodeType': '742',
                'name': 'user1',
              };

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/verify-dealer'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async {
                return const HttpResponseModel(data: data);
              });

              final dealerInfo = await sut.getDealerInfo('info');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/verify-dealer'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('info'));
              expect(dealerInfo?.publicDealerUuid, equals('123456'));
              expect(dealerInfo?.dealerCodeType, equals('742'));
              expect(dealerInfo?.name, equals('user1'));
            },
          );

          test(
            'should return null if there a error of response',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(DioError(
                requestOptions: requestOptions,
                response: Response(
                  requestOptions: requestOptions,
                  statusCode: 404,
                ),
              ));

              final result = await sut.getDealerInfo('info');

              // Then
              expect(result, null);
            },
          );

          test(
            'should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getUsersForDealerCode()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123456');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/users'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: [
                    {
                      'publicUserUuid': 'publicUserUuid',
                      'completeName': 'completeName',
                    }
                  ],
                ),
              );

              final userLoginModel = await sut.getUsersForDealerCode('123');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/users'),
              );
              expect(userLoginModel, isNotEmpty);
            },
          );

          test(
            'Should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.storeDealerCode()',
        () {
          test(
            'should store dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.storeString(any, any))
                  .thenAnswer((_) async => '123456');

              when(localDatabase.write(any, any, any)).thenAnswer(
                  (_) async => const DealerCodeAccessHistoryModel());

              await sut.storeDealerCode('123456');

              final captured = verify(
                localDatabase.write(
                  captureAny,
                  captureAny,
                  captureAny,
                ),
              ).captured;

              // Then
              verify(
                localService.storeString(
                  captureAny,
                  captureAny,
                ),
              ).called(1);

              expect(captured[0], equals('dealer-codes'));
              expect(captured[1], equals('123456'));
              expect(captured[2]['date'], isNotEmpty);
              expect(captured[2]['dealerCode'], equals('123456'));
            },
          );
        },
      );

      group(
        '.clearDealerCode()',
        () {
          test(
            'Should delete dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.delete(any)).thenAnswer((_) async => {});

              sut.clearDealerCode();

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getStoredDealerCode()',
        () {
          test(
            'Should read dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.readString(any))
                  .thenAnswer((_) => 'dealer-code');

              final result = sut.getStoredDealerCode();

              // Then
              expect(result, 'dealer-code');
            },
          );
        },
      );

      group(
        '.create()',
        () {
          test(
            'should throw exception when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'IntegrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'userName',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'Validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const expectedData = {
                'firstName': 'firstName',
                'lastName': 'lastName',
                'pin': '0000',
                'title': 'title',
                'publicDealerUuid': 'publicDealerUuid',
                'email': 'email',
                'username': 'username',
                'password': '1111',
                'mobileNumber': 'mobileNumber',
                'isPasswordEncoded': false,
                'integrationId': 'integrationId',
              };

              const data = {
                'publicUserUuid': 'publicUserUuid',
                'completeName': 'completeName',
              };

              // When
              when(
                service.post(
                  Uri.parse('$baseUrl/api/v3/registration/register-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenAnswer((_) async => const HttpResponseModel(data: data));

              final userLoginModel = await sut.create(
                dealerCode: '123456',
                publicDealerUuid: 'publicDealerUuid',
                integrationId: 'integrationId',
                mobileNumber: 'mobileNumber',
                firstName: 'firstName',
                lastName: 'lastName',
                title: 'title',
                email: 'email',
                username: 'username',
                password: '1111',
                pin: '0000',
              );

              final captured = verify(
                service.post(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                  data: captureAnyNamed('data'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/register-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('123456'));
              expect(captured[3], equals(expectedData));
              expect(userLoginModel.publicUserUuid, equals('publicUserUuid'));
              expect(userLoginModel.completeName, equals('completeName'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.validateUsernameEmail()',
        () {
          test(
            'Should exception error when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/check-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.validateUsernameEmail(
                email: 'email',
                username: 'username',
              );

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then

              expect(
                captured[0].toString(),
                contains('/api/v3/registration/check-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['username'], equals('username'));
              expect(captured[2]['email'], equals('email'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getLastAccessDate()',
        () {
          test(
            'should return null if date is empty',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => '');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return null if date have a blank space',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => ' ');

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isNull);
            },
          );

          test(
            'should return a DateTime',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any))
                  .thenAnswer((_) => DateTime.now().toString());

              final date = sut.getLastAccessDate('foo');

              // Then
              expect(date, isA<DateTime>());
            },
          );

          test(
            'should return a null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.readString(any)).thenAnswer((_) => 'foo');
              when(localService.delete(any)).thenAnswer((_) async => {});

              final result = sut.getLastAccessDate('foo');

              // Then
              expect(result, isNull);
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.deleteLastAccessDate()',
        () {
          test(
            'verify if localService is called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              //When
              when(localService.delete(any)).thenAnswer((_) async => {});

              await sut.deleteLastAccessDate('foo');

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getDealerInfo()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const data = {
                'publicDealerUuid': '123456',
                'dealerCodeType': '742',
                'name': 'user1',
              };

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/verify-dealer'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async {
                return const HttpResponseModel(data: data);
              });

              final dealerInfo = await sut.getDealerInfo('info');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/verify-dealer'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('info'));
              expect(dealerInfo?.publicDealerUuid, equals('123456'));
              expect(dealerInfo?.dealerCodeType, equals('742'));
              expect(dealerInfo?.name, equals('user1'));
            },
          );

          test(
            'should return null if there a error of response',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(DioError(
                requestOptions: requestOptions,
                response: Response(
                  requestOptions: requestOptions,
                  statusCode: 404,
                ),
              ));

              final result = await sut.getDealerInfo('info');

              // Then
              expect(result, null);
            },
          );

          test(
            'should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getDealerInfo('info');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getUsersForDealerCode()',
        () {
          test(
            'should return exception when offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(connectivityService.validateOnline())
                  .thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123456');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/users'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: [
                    {
                      'publicUserUuid': 'publicUserUuid',
                      'completeName': 'completeName',
                    }
                  ],
                ),
              );

              final userLoginModel = await sut.getUsersForDealerCode('123');

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/users'),
              );
              expect(userLoginModel, isNotEmpty);
            },
          );

          test(
            'Should throw exception',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.getUsersForDealerCode('123');
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.storeDealerCode()',
        () {
          test(
            'should store dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localService.storeString(any, any))
                  .thenAnswer((_) async => '123456');

              when(localDatabase.write(any, any, any)).thenAnswer(
                  (_) async => const DealerCodeAccessHistoryModel());

              await sut.storeDealerCode('123456');

              final captured = verify(
                localDatabase.write(
                  captureAny,
                  captureAny,
                  captureAny,
                ),
              ).captured;

              // Then
              verify(
                localService.storeString(
                  captureAny,
                  captureAny,
                ),
              ).called(1);

              expect(captured[0], equals('dealer-codes'));
              expect(captured[1], equals('123456'));
              expect(captured[2]['date'], isNotEmpty);
              expect(captured[2]['dealerCode'], equals('123456'));
            },
          );
        },
      );

      group(
        '.clearDealerCode()',
        () {
          test(
            'Should delete dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.delete(any)).thenAnswer((_) async => {});

              sut.clearDealerCode();

              // Then
              verify(localService.delete(any)).called(1);
            },
          );
        },
      );

      group(
        '.getStoredDealerCode()',
        () {
          test(
            'Should read dealerCode',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(localService.readString(any))
                  .thenAnswer((_) => 'dealer-code');

              final result = sut.getStoredDealerCode();

              // Then
              expect(result, 'dealer-code');
            },
          );
        },
      );

      group(
        '.create()',
        () {
          test(
            'should throw exception when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'IntegrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'userName',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'Validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );

              const expectedData = {
                'firstName': 'firstName',
                'lastName': 'lastName',
                'pin': '0000',
                'title': 'title',
                'publicDealerUuid': 'publicDealerUuid',
                'email': 'email',
                'username': 'username',
                'password': '1111',
                'mobileNumber': 'mobileNumber',
                'isPasswordEncoded': false,
                'integrationId': 'integrationId',
              };

              const data = {
                'publicUserUuid': 'publicUserUuid',
                'completeName': 'completeName',
              };

              // When
              when(
                service.post(
                  Uri.parse('$baseUrl/api/v3/registration/register-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenAnswer((_) async => const HttpResponseModel(data: data));

              final userLoginModel = await sut.create(
                dealerCode: '123456',
                publicDealerUuid: 'publicDealerUuid',
                integrationId: 'integrationId',
                mobileNumber: 'mobileNumber',
                firstName: 'firstName',
                lastName: 'lastName',
                title: 'title',
                email: 'email',
                username: 'username',
                password: '1111',
                pin: '0000',
              );

              final captured = verify(
                service.post(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                  data: captureAnyNamed('data'),
                ),
              ).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('/api/v3/registration/register-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['dealer-code'], equals('123456'));
              expect(captured[3], equals(expectedData));
              expect(userLoginModel.publicUserUuid, equals('publicUserUuid'));
              expect(userLoginModel.completeName, equals('completeName'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.post(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                  data: anyNamed('data'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.create(
                  dealerCode: '123456',
                  publicDealerUuid: 'publicDealerUuid',
                  integrationId: 'integrationId',
                  mobileNumber: 'mobileNumber',
                  firstName: 'firstName',
                  lastName: 'lastName',
                  title: 'title',
                  email: 'email',
                  username: 'username',
                  password: '1111',
                  pin: '0000',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.validateUsernameEmail()',
        () {
          test(
            'Should exception error when is offline',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                connectivityService.validateOnline(),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'validate correct parameters',
            () async {
              // Given
              const baseUrl = 'https://httpbin.org/';
              final sut = AuthServiceImpl(
                baseURL: baseUrl,
                securityToken: 'foo',
              );
              // When
              when(
                service.get(
                  Uri.parse('$baseUrl/api/v3/registration/check-user'),
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.validateUsernameEmail(
                email: 'email',
                username: 'username',
              );

              final captured = verify(
                service.get(
                  captureAny,
                  headers: captureAnyNamed('headers'),
                  params: captureAnyNamed('params'),
                ),
              ).captured;

              // Then

              expect(
                captured[0].toString(),
                contains('/api/v3/registration/check-user'),
              );
              expect(captured[1]['X-security-token'], equals('foo'));
              expect(captured[2]['username'], equals('username'));
              expect(captured[2]['email'], equals('email'));
            },
          );

          test(
            'should throw exception if there is a bad response',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(
                DioError(
                  requestOptions: requestOptions,
                  response: Response(
                    requestOptions: requestOptions,
                    statusCode: 400,
                  ),
                ),
              );

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );

          test(
            'should throw exception if error is different to DioError',
            () async {
              // Given
              Object? error;
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(
                service.get(
                  any,
                  headers: anyNamed('headers'),
                  params: anyNamed('params'),
                ),
              ).thenThrow(CustomException());

              try {
                await sut.validateUsernameEmail(
                  email: 'email',
                  username: 'username',
                );
              } catch (e) {
                error = e;
              }

              // Then
              expect(error, isA<CustomException>());
            },
          );
        },
      );

      group(
        '.getMyProfile()',
        () {
          test(
            'Check correct parameters',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer((_) async => AuthenticatedResponse.create());

              await sut.getMyProfile();

              final captured = verify(service.get(
                captureAny,
                headers: captureAnyNamed('headers'),
                params: captureAnyNamed('params'),
              )).captured;

              // Then
              expect(
                  captured[0].toString(), contains('api/v3/registration/user'));
              expect(captured[1]['X-Authorization-Truvideo'], isNull);
              expect(captured[2]['account-uid'], equals(null));
            },
          );

          test(
            'Should return User model in case of success',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              const user = UserModel(
                publicUserUuid: '1234',
                emailAddress: 'emailAddress',
                firstName: 'firstName',
                lastName: 'lastName',
                role: 'role',
                title: 'title',
              );

              // When
              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer(
                (_) async => HttpResponseModel(data: user.toJson()),
              );

              final result = await sut.getMyProfile();

              // Then
              expect(result, equals(user));
            },
          );

          test(
            'Should return null in case of error',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              const user = UserModel(
                publicUserUuid: '1234',
                emailAddress: 'emailAddress',
                firstName: 'firstName',
                lastName: 'lastName',
                role: 'role',
                title: 'title',
              );

              // When
              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(data: user),
              );

              final result = await sut.getMyProfile();

              // Then
              expect(result, isNull);
            },
          );
        },
      );

      group(
        '.getUserSettings()',
        () {
          test(
            'Check correct parameters',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer(
                (_) async => const HttpResponseModel(
                  data: [
                    {
                      'key': 'key',
                      'type': 'type',
                    },
                  ],
                ),
              );

              await sut.getUserSettings();

              final captured = verify(service.get(
                captureAny,
                headers: captureAnyNamed('headers'),
                params: captureAnyNamed('params'),
              )).captured;

              // Then
              expect(
                captured[0].toString(),
                contains('api/v3/registration/load-settings'),
              );
              expect(captured[1]['X-Authorization-Truvideo'], isNull);
              expect(captured[2]['account-uid'], isNull);
            },
          );

          test(
            'Check write parameters',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localDatabase.write(any, any, any))
                  .thenAnswer((_) async => 'settings');

              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer((_) async => const HttpResponseModel(data: [
                    {
                      'key': 'key',
                      'type': 'type',
                    }
                  ]));

              await sut.getUserSettings();

              final captured = verify(
                localDatabase.write(captureAny, captureAny, captureAny),
              ).captured;

              // Then
              expect(captured[0], equals('user-settings'));
              expect(captured[1], equals('settings'));
            },
          );

          test(
            'Should return a list of UserSettingsModel in case of success',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              const expectedData = [
                UserSettingsModel(
                  key: 'key',
                  type: 'type',
                ),
              ];

              // When
              when(localDatabase.write(any, any, any))
                  .thenAnswer((_) async => 'settings');

              when(service.get(
                any,
                headers: anyNamed('headers'),
                params: anyNamed('params'),
              )).thenAnswer((_) async => const HttpResponseModel(data: [
                    {
                      'key': 'key',
                      'type': 'type',
                    }
                  ]));

              final result = await sut.getUserSettings();

              // Then
              expect(result, equals(expectedData));
            },
          );
        },
      );

      group(
        '.getCachedUserSettings()',
        () {
          test(
            'Should return null if read is null',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              // When
              when(localDatabase.read(any, any)).thenAnswer((_) async => null);

              final result = await sut.getCachedUserSettings();

              // Then
              expect(result, isNull);
            },
          );

          test(
            'Read method should be called',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );
              const userSettings = UserSettingsModel(key: 'key', type: 'type');

              // When
              when(localDatabase.read(any, any))
                  .thenAnswer((_) async => [jsonEncode(userSettings)]);

              await sut.getCachedUserSettings();

              verify(
                localDatabase.read(captureAny, captureAny),
              ).called(1);

              // Then
            },
          );

          test(
            'Should return a list of UserSettingsModel in case of success',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              const userSettings = UserSettingsModel(key: 'key', type: 'type');

              // When
              when(localDatabase.read(any, any))
                  .thenAnswer((_) async => [jsonEncode(userSettings)]);

              final result = await sut.getCachedUserSettings();

              // Then
              expect(result, equals([userSettings]));
            },
          );

          test(
            'Should return empty in case of parsing error',
            () async {
              // Given
              final sut = AuthServiceImpl(
                baseURL: 'https://httpbin.org/',
                securityToken: 'foo',
              );

              const userSettings = [];

              // When
              when(localDatabase.read(any, any))
                  .thenAnswer((_) async => userSettings);

              final result = await sut.getCachedUserSettings();

              // Then
              expect(result, isEmpty);
            },
          );
        },
      );
    },
  );
}
