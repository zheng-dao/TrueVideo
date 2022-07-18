// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/user_dealer.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    @Default("") String publicUserUuid,
    @Default("") String firstName,
    @Default("") String lastName,
    @Default("") String title,
    @Default("") String emailAddress,
    @Default("") String role,
    UserDealerModel? dealer,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  String get displayName {
    final p = <String>[];
    if (firstName.trim().isNotEmpty) {
      p.add(firstName.trim());
    }

    if (lastName.trim().isNotEmpty) {
      p.add(lastName.trim());
    }

    return p.join(" ");
  }
}
