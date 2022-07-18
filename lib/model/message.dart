// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/converter/date.dart';
import 'package:truvideo_enterprise/model/message_user.dart';

part 'message.freezed.dart';

part 'message.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const MessageModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageModel({
    @Default("") String uid,
    @Default("") String auxUID,
    @Default("") String body,
    @Default("") String source,
    @Default("") String type,
    @Default("") String entityType,
    @Default("") String applicationUID,
    @Default("") String channelUID,
    @Default("") String imageURL,
    @Default("") String displayName,
    @Default("") String status,
    @Default("") String accountUID,
    MessageUserModel? createdBy,
    @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
    @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
