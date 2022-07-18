import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_type_model.freezed.dart';
part 'video_type_model.g.dart';

@freezed
class VideoTypeModel with _$VideoTypeModel {
  factory VideoTypeModel({
    required String id,
    @Default('') String description,
  }) = _VideoTypeModel;

  factory VideoTypeModel.fromJson(Map<String, dynamic> json) => _$VideoTypeModelFromJson(json);
}
