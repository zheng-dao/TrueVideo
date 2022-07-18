// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

part 'customer.g.dart';

@freezed
class CustomerModel with _$CustomerModel {
  const CustomerModel._();

  @JsonSerializable(explicitToJson: true)
  const factory CustomerModel({
    required int id,
    @Default("") String firstName,
    @Default("") String lastName,
    @Default("") String mobileNumber,
    @Default("") String email,
  }) = _CustomerModel;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);

  String get displayName => [firstName, lastName].where((e) => e.trim().isNotEmpty).join(" ");
}
