import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/available_option/config_item/config_item.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note.dart';

part 'available_option.freezed.dart';

part 'available_option.g.dart';

@freezed
class AvailableOption with _$AvailableOption {
  const AvailableOption._();

  @JsonSerializable(explicitToJson: true)
  const factory AvailableOption({
    @Default("") String uid,
    @Default("") String type,
    @Default(true) enabled,
    @Default(<ConfigItem>[]) List<ConfigItem> config,
    @Default(false) bool selectedValue,
    @Default(<AvailableOption>[]) List<AvailableOption> availableOptions,
    @Default(<ExtraNote>[]) List<ExtraNote> extraNotes,
  }) = _AvailableOption;


  factory AvailableOption.fromJson(Map<String, dynamic> json) => _$AvailableOptionFromJson(json);

  String get color {
    String result = '';

    for (var item in config) {
      if (item.classObject is String) if (item.classObject != "") result = item.classObject;
      if (item.colorName != "") result = item.colorName;
    }

    return result.toUpperCase();
  }

  String get displayName {
    String result = '';

    for (var item in config) {
      if (item.displayName != "") result = item.displayName;
    }

    return result;
  }

  String get name {
    String result = '';
    for (var item in config) {
      if (item.name != "") result = item.name;
    }

    return result.toUpperCase();
  }

  String get optionClass {
    String result = "";
    for (var item in config) {
      if (item.classObject != null && item.classObject != "") result = "${item.classObject}";
    }

    return result;
  }

  String getColorName(String inputType) {
    String result = "";
    switch (inputType) {
      case "CHECKBOX":
      case "OPTION_MEASURE":
        result = name;
        break;
      default:
    }
    return result;
  }
}
