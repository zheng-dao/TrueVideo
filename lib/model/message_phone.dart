// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_phone.freezed.dart';

part 'message_phone.g.dart';

@freezed
class MessagePhoneModel with _$MessagePhoneModel {
  const MessagePhoneModel._();

  @JsonSerializable(explicitToJson: true)
  const factory MessagePhoneModel({
    @Default("") String countryCode,
    @Default("") String isoCode,
    @Default("") String e164,
    @Default("") String number,
  }) = _MessagePhoneModel;

  factory MessagePhoneModel.fromJson(Map<String, dynamic> json) => _$MessagePhoneModelFromJson(json);
}
