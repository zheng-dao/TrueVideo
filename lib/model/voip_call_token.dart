// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'voip_call_token.freezed.dart';

part 'voip_call_token.g.dart';

@freezed
class VoipCallTokenModel with _$VoipCallTokenModel {
  const VoipCallTokenModel._();

  @JsonSerializable(explicitToJson: true)
  const factory VoipCallTokenModel({
    @Default("") String identity,
    @Default("") String token,
  }) = _VoipCallTokenModel;

  factory VoipCallTokenModel.fromJson(Map<String, dynamic> json) => _$VoipCallTokenModelFromJson(json);
}
