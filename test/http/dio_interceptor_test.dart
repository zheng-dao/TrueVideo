import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truvideo_enterprise/service/http/dio_interceptor.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

import 'dio_interceptor_test.mocks.dart';

@GenerateMocks([LogEventService, ErrorInterceptorHandler])
void main() {
  setUp(
    () async {
      await GetIt.I.reset();
    },
  );

  late MockLogEventService service;
  late MockErrorInterceptorHandler errorInterceptorHandler;
  group('CustomDioInterceptor', () {
    setUp(
      () {
        service = MockLogEventService();
        errorInterceptorHandler = MockErrorInterceptorHandler();

        GetIt.I.registerSingleton<LogEventService>(service);

        when(errorInterceptorHandler.next(any)).thenAnswer((_) {});
      },
    );

    group('.onError()', () {
      test('should call .logEventError', () {
        // Given
        final sut = CustomDioInterceptor();

        // When
        when(service.logEventError(any, any)).thenAnswer((_) async => {});

        sut.onError(
          DioError(
            requestOptions: RequestOptions(path: 'fuu'),
          ),
          errorInterceptorHandler,
        );

        // Then
        verify(service.logEventError(any, any)).called(1);
      });
    });
  });
}
