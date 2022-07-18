// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_upload_video.freezed.dart';

part 'video_upload_video.g.dart';

@freezed
class VideoUploadVideoDTO with _$VideoUploadVideoDTO {
  const VideoUploadVideoDTO._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoUploadVideoDTO({
    @Default("") String thumbnail,
    @Default("") String videoLink,
    @Default(0) int length,
    @Default("") String videoTag,
    @Default("") String videoType,
    @Default("") String description,
  }) = _VideoUploadVideoDTO;

  factory VideoUploadVideoDTO.fromJson(Map<String, dynamic> json) => _$VideoUploadVideoDTOFromJson(json);
}
