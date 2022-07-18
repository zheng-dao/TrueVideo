import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_info.freezed.dart';

part 'video_info.g.dart';

@freezed
class VideoInfoModel with _$VideoInfoModel {
  const VideoInfoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VideoInfoModel({
    @Default("") String path,
    @Default(0.0) double width,
    @Default(0.0) double height,
    @Default(0) int durationMillis,
    @Default(0) int rotation,
    @Default(0) int size,
  }) = _VideoInfoModel;

  factory VideoInfoModel.fromJson(Map<String, dynamic> json) => _$VideoInfoModelFromJson(json);
}
