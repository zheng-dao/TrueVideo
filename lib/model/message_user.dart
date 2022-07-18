// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_user.freezed.dart';

part 'message_user.g.dart';

@freezed
class MessageUserModel with _$MessageUserModel {
  const MessageUserModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessageUserModel({
    @Default("") String uid,
    @Default("") String displayName,
  }) = _MessageUserModel;

  factory MessageUserModel.fromJson(Map<String, dynamic> json) => _$MessageUserModelFromJson(json);
}
