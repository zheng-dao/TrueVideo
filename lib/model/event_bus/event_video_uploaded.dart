// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_video_uploaded.freezed.dart';

part 'event_video_uploaded.g.dart';

@freezed
class EventVideoUploadedModel with _$EventVideoUploadedModel {
  const EventVideoUploadedModel._();

  @JsonSerializable(explicitToJson: true)
  const factory EventVideoUploadedModel({
    @Default(0) int orderID,
  }) = _EventVideoUploadedModel;

  factory EventVideoUploadedModel.fromJson(Map<String, dynamic> json) => _$EventVideoUploadedModelFromJson(json);
}
