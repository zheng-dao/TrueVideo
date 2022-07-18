// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_number_country.freezed.dart';

part 'phone_number_country.g.dart';

@freezed
class PhoneNumberCountryModel with _$PhoneNumberCountryModel {
  const PhoneNumberCountryModel._();

  @JsonSerializable(explicitToJson: true)
  const factory PhoneNumberCountryModel({
    @Default("") String isoCode,
    @Default("") String countryCode,
    @Default("") String internationalMobileMask,
    @Default("") String nationalMobileMask,
    @Default("") String internationalInlineMask,
    @Default("") String nationalInlineMask,
    @Default("") String name,
  }) = _PhoneNumberCountryModel;

  factory PhoneNumberCountryModel.fromJson(Map<String, dynamic> json) => _$PhoneNumberCountryModelFromJson(json);
}
