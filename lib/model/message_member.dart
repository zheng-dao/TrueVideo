// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/message_phone.dart';

import 'message.dart';

part 'message_member.freezed.dart';

part 'message_member.g.dart';

@freezed
class MessageMemberModel with _$MessageMemberModel {
  const MessageMemberModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageMemberModel({
    @Default("") String uid,
    @Default("") String displayName,
    MessagePhoneModel? phone,
    @Default("") String channelUid,
    @Default(0) int unreadMessages,
    @Default(false) bool pinned,
    @Default(false) bool enabled,
    @Default(false) bool visible,
    MessageModel? lastMessage,
  }) = _MessageMemberModel;

  factory MessageMemberModel.fromJson(Map<String, dynamic> json) => _$MessageMemberModelFromJson(json);
}
