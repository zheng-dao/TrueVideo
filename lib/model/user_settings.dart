import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
class UserSettingsModel with _$UserSettingsModel {
  const UserSettingsModel._();

  @JsonSerializable(explicitToJson: true)
  const factory UserSettingsModel({
    @Default("") String key,
    String? value,
    String? displayName,
    @Default("") String type,
    List<UserSettingsModel>? children
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);
}