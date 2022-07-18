import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/camera/camera_video_file.dart';

part 'processing_video.freezed.dart';

part 'processing_video.g.dart';

@freezed
class VideoEditorProcessingVideoModel with _$VideoEditorProcessingVideoModel {
  const VideoEditorProcessingVideoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoEditorProcessingVideoModel({
    @Default("") String originalPath,
    @Default(false) bool loading,
    dynamic error,
    required CameraVideoFileModel video,
  }) = _VideoEditorProcessingVideoModel;

  factory VideoEditorProcessingVideoModel.fromJson(Map<String, dynamic> json) => _$VideoEditorProcessingVideoModelFromJson(json);
}
