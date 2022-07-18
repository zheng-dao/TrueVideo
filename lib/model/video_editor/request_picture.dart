import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_picture.freezed.dart';

part 'request_picture.g.dart';

@freezed
class VideoEditorRequestPictureModel with _$VideoEditorRequestPictureModel {
  const VideoEditorRequestPictureModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoEditorRequestPictureModel({
    @Default("") String path,
    @Default(0.0) double rotation,
    @Default(false) bool flipHorizontal,
  }) = _VideoEditorRequestPictureModel;

  factory VideoEditorRequestPictureModel.fromJson(Map<String, dynamic> json) => _$VideoEditorRequestPictureModelFromJson(json);
}
