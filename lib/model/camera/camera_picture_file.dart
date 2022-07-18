import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_picture_file.freezed.dart';

part 'camera_picture_file.g.dart';

@freezed
class CameraPictureFileModel with _$CameraPictureFileModel {
  const CameraPictureFileModel._();

  @JsonSerializable(explicitToJson: true)
  const factory CameraPictureFileModel({
    @Default("") String path,
    @Default(0) int size,
    @Default(0.0) double width,
    @Default(0.0) double height,
  }) = _CameraPictureFileModel;

  factory CameraPictureFileModel.fromJson(Map<String, dynamic> json) => _$CameraPictureFileModelFromJson(json);
}
