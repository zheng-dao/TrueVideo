// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/file_attachment.dart';
import 'package:truvideo_enterprise/model/file_info.dart';

import 'converter/date.dart';

part 'text_message.freezed.dart';

part 'text_message.g.dart';

@freezed
class TextMessageModel with _$TextMessageModel {
  const TextMessageModel._();

  @JsonSerializable(explicitToJson: true)
  const factory TextMessageModel({
    @Default(0) int conversationId,
    @Default("") String direction,
    @Default("") String message,
    @Default("") String from,
    @Default("") String to,
    FileInfoModel? attachment,
    FileAttachmentModel? mmsAttachment,
    @Default("") String deliveryStatus,
    @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson) DateTime? dateTimeSent,
  }) = _TextMessageModel;

  factory TextMessageModel.fromJson(Map<String, dynamic> json) => _$TextMessageModelFromJson(json);
}
