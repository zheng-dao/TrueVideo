// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_info.freezed.dart';

part 'file_info.g.dart';

@freezed
class FileInfoModel with _$FileInfoModel {
  const FileInfoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory FileInfoModel({
    required String filename,
    String? fullPath,
    String? originalFileName,
    int? fileSize,
    String? contentType,
    String? fileId,
    bool? isArchived,
  }) = _FileInfoModel;

  factory FileInfoModel.fromJson(Map<String, dynamic> json) => _$FileInfoModelFromJson(json);
}