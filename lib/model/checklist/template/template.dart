import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/definitions/definitions.dart';
import 'package:truvideo_enterprise/model/checklist/item/item.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_item_values/reply_item_values.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';

part 'template.freezed.dart';

part 'template.g.dart';

@freezed
class Template with _$Template {
  const Template._();

  factory Template({
    required String uid,
    @Default("") String accountUID,
    @Default("") String createdAt,
    @Default("") String updatedAt,
    @Default("") String templateName,
    @Default("") String description,
    @Default("") String category,
    @Default("") String subCategory,
    @Default("") String version,
    @Default("") String templateStatus,
    Definitions? definitions,
  }) = _Template;

  factory Template.fromJson(Map<String, dynamic> json) => _$TemplateFromJson(json);

  List<Reply> markAllGreen(List<Reply> currentReplies) {
    List<Reply> newReplies = currentReplies.toList();

    void addDefaultReply(Item item) {
      if ((item.defaultValue ?? "").toString().isNotEmpty) {
        switch (item.inputType) {
          case "MEASURE":
            newReplies.add(
              Reply(
                itemUID: item.uid,
                replyItemValues: [
                  ReplyItemValues(
                    optionGroupUID: item.uid,
                    optionUID: item.uid,
                  ),
                ],
              ),
            );
            break;
          case "COLOR":
          case "CHECKBOX":
            final defaultValue = item.defaultValue;
            newReplies.add(
              Reply(
                itemUID: item.uid,
                replyItemValues: [
                  if (defaultValue != null)
                    ReplyItemValues(
                      optionGroupUID: item.defaultValue!,
                      optionUID: item.defaultValue!,
                    ),
                ],
              ),
            );

            break;
          case "COLOR_MEASURE":
            newReplies.add(
              Reply(
                itemUID: item.uid,
                replyItemValues: [
                  ReplyItemValues(
                    optionGroupUID: item.defaultValue!,
                  ),
                ],
              ),
            );
            break;
          default:
        }
      }
    }

    for (var section in definitions!.sections) {
      for (var item in section.items) {
        int index = newReplies.indexWhere(
          (element) => element.itemUID == item.uid,
        );
        if (index == -1) {
          // item doesnt exists
          addDefaultReply(item);
        }
      }
    }
    return newReplies;
  }

  bool isTemplateCompleted(List<Reply> replies) {
    bool result = true;

    if (definitions?.sections != null) {
      for (Section section in definitions!.sections) {
        if (!section.isSectionComplete(replies)) result = false;
      }
    }
    return result;
  }
}
