import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';
import 'package:truvideo_enterprise/model/converter/date.dart';

part 'video_session.freezed.dart';

part 'video_session.g.dart';

@freezed
class VideoSessionModel with _$VideoSessionModel {
  const VideoSessionModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoSessionModel({
    @Default(<VideoSessionFileModel>[]) List<VideoSessionFileModel> videos,
    @Default(<VideoSessionFileModel>[]) List<VideoSessionFileModel> pictures,
    @Default("") String uid,
    @Default("") String tag,
    @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
  }) = _VideoSessionModel;

  factory VideoSessionModel.fromJson(Map<String, dynamic> json) => _$VideoSessionModelFromJson(json);
}
