import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';

part 'processing_picture.freezed.dart';

part 'processing_picture.g.dart';

@freezed
class VideoEditorProcessingPictureModel with _$VideoEditorProcessingPictureModel {
  const VideoEditorProcessingPictureModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoEditorProcessingPictureModel({
    @Default("") String originalPath,
    @Default(false) bool loading,
    dynamic error,
    required CameraPictureFileModel picture,
  }) = _VideoEditorProcessingPictureModel;

  factory VideoEditorProcessingPictureModel.fromJson(Map<String, dynamic> json) => _$VideoEditorProcessingPictureModelFromJson(json);
}
