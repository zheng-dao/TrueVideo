// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login.freezed.dart';

part 'user_login.g.dart';

@freezed
class UserLoginModel with _$UserLoginModel {
  const UserLoginModel._();

  @JsonSerializable(explicitToJson: true)
  const factory UserLoginModel({
    @Default("") String publicUserUuid,
    @Default("") String completeName,
  }) = _UserLoginModel;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => _$UserLoginModelFromJson(json);
}
