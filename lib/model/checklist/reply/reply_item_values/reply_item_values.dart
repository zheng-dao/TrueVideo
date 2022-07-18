import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_item_values.freezed.dart';

part 'reply_item_values.g.dart';

@freezed
class ReplyItemValues with _$ReplyItemValues {
  const ReplyItemValues._();

  @JsonSerializable(explicitToJson: true)
  const factory ReplyItemValues({
    required String optionGroupUID,
    @Default("") String optionUID,
    String? value,
  }) = _ReplyItemValues;

  factory ReplyItemValues.fromJson(Map<String, dynamic> json) => _$ReplyItemValuesFromJson(json);
}
