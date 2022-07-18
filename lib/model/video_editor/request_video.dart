import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_video.freezed.dart';

part 'request_video.g.dart';

@freezed
class VideoEditorRequestVideoModel with _$VideoEditorRequestVideoModel {
  const VideoEditorRequestVideoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoEditorRequestVideoModel({
    @Default("") String path,
    @Default(0.0) double rotation,
  }) = _VideoEditorRequestVideoModel;

  factory VideoEditorRequestVideoModel.fromJson(Map<String, dynamic> json) => _$VideoEditorRequestVideoModelFromJson(json);
}
