// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

part 'response.g.dart';

@freezed
class HttpResponseModel with _$HttpResponseModel {
  const HttpResponseModel._();

  @JsonSerializable(explicitToJson: true)
  const factory HttpResponseModel({
    int? statusCode,
    String? message,
    Object? data,
    Map<String, List<String>>? headers,
  }) = _HttpResponseModel;

  factory HttpResponseModel.fromJson(Map<String, dynamic> json) => _$HttpResponseModelFromJson(json);
}
