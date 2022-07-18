// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity_reference.freezed.dart';

part 'message_entity_reference.g.dart';

@freezed
class MessageEntityReferenceModel with _$MessageEntityReferenceModel {
  const MessageEntityReferenceModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageEntityReferenceModel({
    @Default(false) bool external,
    @Default("") String entityType,
    @Default("") String entityUID,
  }) = _MessageEntityReferenceModel;

  factory MessageEntityReferenceModel.fromJson(Map<String, dynamic> json) => _$MessageEntityReferenceModelFromJson(json);
}
