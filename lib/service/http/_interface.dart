import 'model/response.dart';

abstract class HttpService {
  Future<HttpResponseModel> get(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  });

  Future<HttpResponseModel> put(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
    dynamic data,
  });

  Future<HttpResponseModel> post(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
    dynamic data,
  });

  Future<HttpResponseModel> delete(
    Uri uri, {
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  });
}
