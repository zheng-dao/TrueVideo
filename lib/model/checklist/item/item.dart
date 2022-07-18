import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/available_option/available_option.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/item/item_config_item/item_config_item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
class Item with _$Item {
  const Item._();

  @JsonSerializable(explicitToJson: true)
  const factory Item({
    @Default("") String uid,
    @Default("") defaultValue,
    @Default("") String inputType,
    @Default(<String>[]) List<String> validations,
    @Default(true) bool skippable,
    @Default(false) bool required,
    @Default(true) bool enabled,
    @Default(<ExtraNote>[]) List<ExtraNote> extraNotes,
    @Default(<AvailableOption>[]) List<AvailableOption> availableOptions,
    @Default(<ItemConfigItem>[]) List<ItemConfigItem> config,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  String get inputName {
    String result = "";
    for (var item in config) {
      if (item.inputName != "") result = item.inputName;
    }
    return result;
  }

  String get inputDescription {
    String result = "";
    for (var item in config) {
      if (item.inputDescription != "") result = item.inputDescription;
    }
    return result;
  }

  AvailableOption? getInitialValue(List<Reply> replies) {
    final selectedReply = replies.firstWhereOrNull((element) => element.itemUID == uid);
    if (selectedReply == null) return null;

    return availableOptions.firstWhereOrNull(
      (element) => element.uid == selectedReply.replyItemValues?.first.optionGroupUID,
    );
  }

  AvailableOption? findOptionByUID(String uid) => availableOptions.firstWhereOrNull((element) => element.uid == uid);

  bool get isColorMeasure => inputType == "COLOR_MEASURE";

  AvailableOption? get getDefaultValue => availableOptions.firstWhereOrNull((element) => element.uid == defaultValue);
}
