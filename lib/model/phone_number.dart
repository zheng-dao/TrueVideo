// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';

part 'phone_number.freezed.dart';

part 'phone_number.g.dart';

@freezed
class PhoneNumberModel with _$PhoneNumberModel {
  const PhoneNumberModel._();

  @JsonSerializable(explicitToJson: true)
  const factory PhoneNumberModel({
    @Default(PhoneNumberCountryModel()) PhoneNumberCountryModel country,
    @Default("") String e164,
    @Default("") String formattedNationalNumber,
    @Default("") String formattedInternationalNumber,
    @Default("") String number,
    @Default(false) bool mobileNumber,
  }) = _PhoneNumberModel;

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) => _$PhoneNumberModelFromJson(json);
}
