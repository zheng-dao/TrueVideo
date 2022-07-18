// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/dealer.dart';

part 'tce_user.freezed.dart';

part 'tce_user.g.dart';

@freezed
class TCEUserModel with _$TCEUserModel {
  const TCEUserModel._();

  @JsonSerializable(explicitToJson: true)
  const factory TCEUserModel({
    @Default(0) int id,
    @Default("") String title,
    @Default("") String firstName,
    @Default("") String middleName,
    @Default("") String lastName,
    @Default("") String emailAddress,
    @Default("") String mobileNumber,
    DealerModel? dealer,
  }) = _TCEUserModel;

  factory TCEUserModel.fromJson(Map<String, dynamic> json) => _$TCEUserModelFromJson(json);

  String get displayName {
    final parts = <String>[firstName, middleName, lastName];
    return parts.where((e) => e.trim().isNotEmpty).join(" ");
  }
}
