import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/section/section_config/section_config.dart';

part 'section.freezed.dart';

part 'section.g.dart';

@freezed
class Section with _$Section {
  const Section._();

  factory Section({
    required String uid,
    @Default(<SectionConfig>[]) List<SectionConfig> config,
    @Default(<Item>[]) List<Item> items,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  int getRequiredLength() {
    int counter = 0;

    // iterates all items adding all of the NOT skippable ones.
    for (var item in items) {
      if (!item.skippable) counter++;
    }
    return counter;
  }

  String get title {
    String result = '';

    for (var configItem in config) {
      if (configItem.name != '') result = configItem.name;
    }

    return result;
  }

  int getFilledDataLength(List<Reply> replies) {
    int counter = 0;
    for (var item in items) {
      // iterates all items and checks for each if a reply with the same uid exists
      // in that case the item has been filled
      for (var reply in replies) {
        if (item.uid == reply.itemUID) {
          switch (item.inputType) {
            // for this cases the item is 100% filled
            case "CHECKBOX":
            case "COLOR":
            case "MEASURE":
              counter++;
              break;
            // for this case we need to validate optionGroupd ID inside the reply exists
            // and its the same as one of the available options
            //inside the selected available options
            case "COLOR_MEASURE":
              final selectedColorUID = reply.optionGroupUID;
              final selectedOption = item.availableOptions.firstWhereOrNull((element) => element.uid == selectedColorUID);

              bool hasAvailableOptions = (selectedOption?.availableOptions ?? []).isNotEmpty;
              if (hasAvailableOptions) {
                if (reply.optionUID != "") counter++;
              } else {
                counter++;
              }
              break;

            default:
          }
        }
      }
    }
    return counter;
  }

  bool isSectionComplete(List<Reply> replies) {
    return getFilledDataLength(replies) >= getRequiredLength();
  }
}
