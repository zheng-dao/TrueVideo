import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_extra_note/reply_extra_note.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_item_values/reply_item_values.dart';

part 'reply.freezed.dart';

part 'reply.g.dart';

@freezed
class Reply with _$Reply {
  const Reply._();

  @JsonSerializable(explicitToJson: true)
  const factory Reply({
    required String itemUID,
    List<ReplyExtraNote>? replyExtraNote,
    List<ReplyItemValues>? replyItemValues,
  }) = _Reply;

  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);

  String? get optionGroupUID {
    if (replyItemValues == null || replyItemValues!.isEmpty) return null;
    return replyItemValues!.first.optionGroupUID;
  }

  String? get optionUID {
    if (replyItemValues == null || replyItemValues!.isEmpty) return null;
    return replyItemValues!.first.optionUID;
  }

  String get getValue {
    String result = '';
    if (replyItemValues == null) return result;
    if (replyItemValues!.first.value == null) return result;
    result = replyItemValues!.first.value!;
    return result;
  }

  bool get onlyColorValueSelected {
    if (replyItemValues == null) return false;
    if (replyItemValues!.isEmpty) return false;

    return optionGroupUID != '' && optionUID == '';
  }
}
