import 'package:freezed_annotation/freezed_annotation.dart';

import 'video_info.dart';

part 'camera_video_file.freezed.dart';

part 'camera_video_file.g.dart';

@freezed
class CameraVideoFileModel with _$CameraVideoFileModel {
  const CameraVideoFileModel._();

  @JsonSerializable(explicitToJson: true)
  const factory CameraVideoFileModel({
    required VideoInfoModel info,
    @Default("") String thumbnailPath,
  }) = _CameraVideoFileModel;

  factory CameraVideoFileModel.fromJson(Map<String, dynamic> json) => _$CameraVideoFileModelFromJson(json);
}
