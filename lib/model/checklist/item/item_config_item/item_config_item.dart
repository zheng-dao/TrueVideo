import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_config_item.freezed.dart';

part 'item_config_item.g.dart';

@freezed
class ItemConfigItem with _$ItemConfigItem {
  const ItemConfigItem._();

  @JsonSerializable(explicitToJson: true)
  const factory ItemConfigItem({
    @Default("") String inputDescription,
    @Default("") String inputName,
    @Default("") String outputDescription,
    @Default("") String outputName,
    @Default("") String type,
    @Default("") String unit,
    @Default("") String precision,
    @Default("") String inputType,
    int? inputOrder,
    int? outputOrder,
    dynamic classObject,
    @Default(false) bool isPrintable,
    @Default("") String visibleFor,
  }) = _ItemConfigItem;

  factory ItemConfigItem.fromJson(Map<String, dynamic> json) => _$ItemConfigItemFromJson(json);
}
