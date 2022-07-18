import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';

class CustomDioInterceptor extends Interceptor {
  bool get _log => true;

  CustomDioInterceptor();

  _printRequestOptions(RequestOptions options) {
    if (_log) {
      log("URI: ${options.uri}");
      log("Method: ${options.method}");
      log("Data: ${options.data?.toString()}");
      log("Headers: ${options.headers.toString()}");
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    if (_log) {
      log("New request:");
      _printRequestOptions(options);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    LogEventService service = GetIt.I.get();
    service.logEventError(err, err.stackTrace);

    if (_log) {
      log("Request error:", error: err, stackTrace: err.stackTrace);
      _printRequestOptions(err.requestOptions);
      log("Message: ${err.message}");
      log("Response: ${err.response}");
      log("Type: ${err.type}");
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    if (_log) {
      log("Request response:");
      log("URI: ${response.realUri}");
      log("Status code: ${response.statusCode}");
      log("Status message: ${response.statusMessage}");
      log("Data: ${response.data}");
      log("Headers: ${response.headers}");
    }
  }
}
