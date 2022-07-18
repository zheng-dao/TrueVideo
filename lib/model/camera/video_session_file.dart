import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_session_file.freezed.dart';

part 'video_session_file.g.dart';

@freezed
class VideoSessionFileModel with _$VideoSessionFileModel {
  const VideoSessionFileModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoSessionFileModel({
    @Default("") String path,
    @Default(false) bool selfie,
  }) = _VideoSessionFileModel;

  factory VideoSessionFileModel.fromJson(Map<String, dynamic> json) => _$VideoSessionFileModelFromJson(json);
}
