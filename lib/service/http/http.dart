import 'package:dio/dio.dart' as dio;
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/http/dio_interceptor.dart';

import '_interface.dart';
import 'model/response.dart';

class HttpServiceImpl implements HttpService {
  late dio.Dio _client;
  late Map<String, dynamic> _headers;
  final _exceptionInterceptor = <int, Function()>{};

  HttpServiceImpl({dio.Dio? client}) {
    _headers = <String, dynamic>{};
    _client = client ?? dio.Dio(dio.BaseOptions(headers: _headers));
    _client.interceptors.add(CustomDioInterceptor());
  }

  addInterceptorException(int code, Function() exception) {
    _exceptionInterceptor[code] = exception;
  }

  Future<HttpResponseModel> _base({
    required Uri uri,
    required String method,
    dynamic data,
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    final options = dio.Options(
      method: method,
      headers: headers,
    );

    final currentParams = params.entries.map((e) => "${e.key}=${e.value}").join("&");
    final currentURI = Uri.parse(uri.toString() + (currentParams.trim().isNotEmpty ? "?$currentParams" : ""));
    final response = await _client.requestUri(
      currentURI,
      data: data,
      options: options,
    );

    final exceptionInterceptor = _exceptionInterceptor[response.statusCode];
    if (exceptionInterceptor != null) {
      exceptionInterceptor.call();
    }

    return HttpResponseModel(
      statusCode: response.statusCode,
      message: response.statusMessage,
      data: response.data,
      headers: response.headers.map,
    );
  }

  @override
  Future<HttpResponseModel> delete(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) =>
      _base(
        uri: uri,
        method: "DELETE",
        headers: headers,
        params: params,
      );

  @override
  Future<HttpResponseModel> get(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) =>
      _base(
        uri: uri,
        method: "GET",
        headers: headers,
        params: params,
      );

  @override
  Future<HttpResponseModel> post(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
    dynamic data,
  }) =>
      _base(
        uri: uri,
        method: "POST",
        data: data,
        headers: headers,
        params: params,
      );

  @override
  Future<HttpResponseModel> put(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
    dynamic data,
  }) =>
      _base(
        uri: uri,
        method: "PUT",
        data: data,
        headers: headers,
        params: params,
      );
}
