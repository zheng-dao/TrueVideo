// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/message_member.dart';

import 'converter/date.dart';

part 'message_channel.freezed.dart';

part 'message_channel.g.dart';

@freezed
class MessageChannelModel with _$MessageChannelModel {
  const MessageChannelModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageChannelModel({
    @Default(<MessageMemberModel>[]) List<MessageMemberModel> members,
    @Default("") String uid,
    @Default("") String displayName,
    @Default("") String entityType,
    @Default("") String type,
    @Default("") String accountUID,
    @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
    @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
  }) = _MessageChannelModel;

  factory MessageChannelModel.fromJson(Map<String, dynamic> json) => _$MessageChannelModelFromJson(json);

  String getName({
    String subjectUID = "",
    String accountUID = "",
  }) {
    if (type == "DIRECT_MESSAGE") {
      final m = members.where((e) => e.uid != subjectUID && e.uid != accountUID).toList();
      if (m.isEmpty) return "";
      return m[0].displayName.trim();
    }

    return displayName.trim();
  }
}
