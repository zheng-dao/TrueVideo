// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/text_message.dart';

part 'file_attachment.freezed.dart';

part 'file_attachment.g.dart';

@freezed
class FileAttachmentModel with _$FileAttachmentModel {
  const FileAttachmentModel._();

  @JsonSerializable(explicitToJson: true)
  const factory FileAttachmentModel({
    String? url,
    String? contentType,
    String? s3FileKey,
    TextMessageModel? message,
  }) = _FileAttachmentModel;

  factory FileAttachmentModel.fromJson(Map<String, dynamic> json) => _$FileAttachmentModelFromJson(json);
}
