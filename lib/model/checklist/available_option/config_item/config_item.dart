import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_item.freezed.dart';

part 'config_item.g.dart';

@freezed
class ConfigItem with _$ConfigItem {
  const ConfigItem._();

  @JsonSerializable(explicitToJson: true)
  const factory ConfigItem({
    @Default("") String name,
    @Default("") String type,
    @Default("") String colorName,
    @Default("") String description,
    @Default("") String displayName,
    @JsonKey(name: "class") dynamic classObject,
  }) = _ConfigItem;

  factory ConfigItem.fromJson(Map<String, dynamic> json) => _$ConfigItemFromJson(json);
}
