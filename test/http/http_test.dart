import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/http/http.dart';
import 'package:truvideo_enterprise/service/http/model/response.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

import 'http_test.mocks.dart';

@GenerateMocks([Dio, LogEventService, Interceptor])
void main() {
  setUp(
    () async {
      await GetIt.I.reset();
    },
  );
  group(
    'HttpServiceImpl',
    () {
      late MockDio client;
      late MockInterceptor interceptor;

      late MockLogEventService logEventService;

      setUp(
        () {
          client = MockDio();
          interceptor = MockInterceptor();

          logEventService = MockLogEventService();

          GetIt.I.registerSingleton<LogEventService>(logEventService);

          // ignore: void_checks
          when(interceptor.onError(any, any)).thenReturn({});
          // ignore: void_checks
          when(interceptor.onRequest(any, any)).thenReturn({});
          // ignore: void_checks
          when(interceptor.onResponse(any, any)).thenReturn({});
          when(client.interceptors).thenReturn(Interceptors());
        },
      );
      test('is initialized', () {
        // Given
        final sut = HttpServiceImpl();

        // When, Then
        expect(sut, isNotNull);
      });

      group(
        '.delete()',
        () {
          test(
            'Should return a HttpResponseModel ',
            () async {
              // Given
              final sut = HttpServiceImpl(client: client);
              final headers = {'foo': 'var'};
              final params = {'faa': 'var'};
              const expectedData = HttpResponseModel(
                statusCode: null,
                message: null,
                data: null,
                headers: {},
              );

              // When
              when(
                client.requestUri(
                  Uri.parse('https://httpbin.org/?faa=var'),
                  data: anyNamed('data'),
                  options: anyNamed('options'),
                ),
              ).thenAnswer(
                (_) async =>
                    Response(requestOptions: RequestOptions(path: 'foo')),
              );

              final result = await sut.delete(
                Uri.parse("https://httpbin.org/"),
                headers: headers,
                params: params,
              );

              // Then
              expect(result, equals(expectedData));
            },
          );
          
        },
      );

      group(
        '.get()',
        () {
          test(
            'Should return a HttpResponseModel',
            () async {
              // Given
              final sut = HttpServiceImpl(client: client);
              final headers = {'foo': 'oo'};
              final params = {'fuu': 'uu'};
              const expectedData = HttpResponseModel(
                statusCode: null,
                message: null,
                data: null,
                headers: {},
              );

              // When
              when(
                client.requestUri(
                  any,
                  data: anyNamed('data'),
                  options: anyNamed('options'),
                ),
              ).thenAnswer(
                (_) async =>
                    Response(requestOptions: RequestOptions(path: 'foo')),
              );

              final result = await sut.get(Uri.parse("https://httpbin.org/"),
                  headers: headers, params: params);

              // Then
              expect(result, equals(expectedData));
            },
          );
        },
      );

      group(
        '.put()',
        () {
          test(
            'Should return a HttpResponseModel',
            () async {
              // Given
              final sut = HttpServiceImpl(client: client);
              final headers = {'fafa': 'fofo'};
              final params = {'fefe': 'fifi'};
              const expectedData = HttpResponseModel(
                statusCode: null,
                message: null,
                data: null,
                headers: {},
              );

              // When
              when(client.requestUri(any,
                      data: anyNamed('data'), options: anyNamed('options')))
                  .thenAnswer(
                (_) async =>
                    Response(requestOptions: RequestOptions(path: 'faa')),
              );

              final result = await sut.put(Uri.parse("https://httpbin.org/"),
                  headers: headers, params: params);

              // Then
              expect(result, equals(expectedData));
            },
          );
        },
      );

      group('.post()', () {
        test('Should return a HttpResponseModel', () async {
          // Given
          final sut = HttpServiceImpl(client: client);
          final headers = {'fafa': 'fofo'};
          final params = {'fefe': 'fifi'};
          const expectedData = HttpResponseModel(
            statusCode: null,
            message: null,
            data: null,
            headers: {},
          );

          // When
          when(client.requestUri(any,
                  data: anyNamed('data'), options: anyNamed('options')))
              .thenAnswer(
            (_) async => Response(requestOptions: RequestOptions(path: 'faa')),
          );

          final result = await sut.post(Uri.parse("https://httpbin.org/"),
              headers: headers, params: params);

          // Then
          expect(result, equals(expectedData));
        });
      });
    },
  );
}
