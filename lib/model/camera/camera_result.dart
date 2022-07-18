import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/core/file.dart';

import 'camera_picture_file.dart';
import 'camera_video_file.dart';

part 'camera_result.freezed.dart';

part 'camera_result.g.dart';

@freezed
class CameraResultModel with _$CameraResultModel {
  const CameraResultModel._();

  @JsonSerializable(explicitToJson: true)
  const factory CameraResultModel({
    required CameraVideoFileModel video,
    @Default(<CameraPictureFileModel>[]) List<CameraPictureFileModel> pictures,
  }) = _CameraResultModel;

  factory CameraResultModel.fromJson(Map<String, dynamic> json) => _$CameraResultModelFromJson(json);

  deleteFiles() {
    CustomFileUtils.delete(video.info.path);
    CustomFileUtils.delete(video.thumbnailPath);

    for (var element in pictures) {
      CustomFileUtils.delete(element.path);
    }
  }
}
