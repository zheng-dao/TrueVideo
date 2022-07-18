// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

part 'location.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const LocationModel._();

  @JsonSerializable(explicitToJson: true)
  const factory LocationModel({
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}
