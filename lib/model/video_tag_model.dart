import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_tag_model.freezed.dart';
part 'video_tag_model.g.dart';

@freezed
class VideoTagModel with _$VideoTagModel {
  factory VideoTagModel({
    @Default('') String key,
    @Default('') String value,
    @Default('') String displayName,
    @Default('') String type,
  }) = _VideoTagModel;

  factory VideoTagModel.fromJson(Map<String, dynamic> json) => _$VideoTagModelFromJson(json);
}
