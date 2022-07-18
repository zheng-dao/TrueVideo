// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'message_authentication_information_sub_entity.dart';

part 'message_authentication_information.freezed.dart';

part 'message_authentication_information.g.dart';

@freezed
class MessageAuthenticationInformationModel with _$MessageAuthenticationInformationModel {
  const MessageAuthenticationInformationModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageAuthenticationInformationModel({
    @Default("") String accountUID,
    @Default("") String subAccountUID,
    @Default(<String>[]) List<String> groups,
    @Default(false) bool authenticated,
    @Default("") String provider,
    MessageAuthenticationInformationSubEntityModel? subAccountMessageableEntity,
    MessageAuthenticationInformationSubEntityModel? subjectMessageableEntity,
  }) = _MessageAuthenticationInformationModel;

  factory MessageAuthenticationInformationModel.fromJson(Map<String, dynamic> json) => _$MessageAuthenticationInformationModelFromJson(json);
}
