import 'package:freezed_annotation/freezed_annotation.dart';

part 'extra_note_config.freezed.dart';

part 'extra_note_config.g.dart';

@freezed
class ExtraNoteConfig with _$ExtraNoteConfig {
  const ExtraNoteConfig._();

  @JsonSerializable(explicitToJson: true)
  const factory ExtraNoteConfig({
    @Default("") String displayName,
    @Default("") String name,
    @Default("") String description,
    @Default("") String type,
    @JsonKey(name: "class") dynamic classObject,
  }) = _ExtraNoteConfig;

  factory ExtraNoteConfig.fromJson(Map<String, dynamic> json) => _$ExtraNoteConfigFromJson(json);
}
