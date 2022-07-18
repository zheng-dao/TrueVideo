import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_form/reply_form.dart';
import 'package:truvideo_enterprise/model/checklist/template/template.dart';

part 'template_reply.freezed.dart';
part 'template_reply.g.dart';

@freezed
class TemplateReply with _$TemplateReply {
  factory TemplateReply({
    required ReplyForm reply,
    required Template template,
  }) = _TemplateReply;

  factory TemplateReply.fromJson(Map<String, dynamic> json) => _$TemplateReplyFromJson(json);
}
