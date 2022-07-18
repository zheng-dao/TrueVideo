// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_upload_image.freezed.dart';

part 'video_upload_image.g.dart';

@freezed
class VideoUploadImageDTO with _$VideoUploadImageDTO {
  const VideoUploadImageDTO._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoUploadImageDTO({
    @Default("") String name,
    @Default("") String fileId,
    @Default("") String contentType,
    @Default("") String url,
    @Default(0) int size,
  }) = _VideoUploadImageDTO;

  factory VideoUploadImageDTO.fromJson(Map<String, dynamic> json) => _$VideoUploadImageDTOFromJson(json);
}
