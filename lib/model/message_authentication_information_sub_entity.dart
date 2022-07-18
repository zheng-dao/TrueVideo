// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/converter/date.dart';
import 'package:truvideo_enterprise/model/message_entity_reference.dart';

part 'message_authentication_information_sub_entity.freezed.dart';

part 'message_authentication_information_sub_entity.g.dart';

@freezed
class MessageAuthenticationInformationSubEntityModel with _$MessageAuthenticationInformationSubEntityModel {
  const MessageAuthenticationInformationSubEntityModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageAuthenticationInformationSubEntityModel({
    MessageEntityReferenceModel? businessReference,
    @Default("") String subAccountUID,
    @Default("") String accountUID,
    @Default("") String uid,
    @Default("") String displayName,
    @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
    @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
  }) = _MessageAuthenticationInformationSubEntityModel;

  factory MessageAuthenticationInformationSubEntityModel.fromJson(Map<String, dynamic> json) =>
      _$MessageAuthenticationInformationSubEntityModelFromJson(json);
}
