// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'converter/date.dart';

part 'message_call_participant.freezed.dart';

part 'message_call_participant.g.dart';

@freezed
class MessageCallParticipantModel with _$MessageCallParticipantModel {
  const MessageCallParticipantModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageCallParticipantModel({
    @Default("") String callSid,
    @Default("") String conferenceSid,
    @Default("") String messageableEntityUID,
    @Default("") String messageableEntityDisplayName,
    @Default("") String status,
    @Default(false) bool hold,
    @Default(false) bool muted,
    @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
  }) = _MessageCallParticipantModel;

  factory MessageCallParticipantModel.fromJson(Map<String, dynamic> json) => _$MessageCallParticipantModelFromJson(json);
}
