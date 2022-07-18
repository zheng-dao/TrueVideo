// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload_video.dart';

import 'video_upload_image.dart';

part 'video_upload.freezed.dart';

part 'video_upload.g.dart';

@freezed
class VideoUploadDTO with _$VideoUploadDTO {
  const VideoUploadDTO._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoUploadDTO({
    VideoUploadVideoDTO? videoDTO,
    @Default(<VideoUploadImageDTO>[]) List<VideoUploadImageDTO> imageDTO,
  }) = _VideoUploadDTO;

  factory VideoUploadDTO.fromJson(Map<String, dynamic> json) => _$VideoUploadDTOFromJson(json);
}
