import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply.dart';

part 'reply_form.freezed.dart';

part 'reply_form.g.dart';

@freezed
class ReplyForm with _$ReplyForm {
  const ReplyForm._();

  @JsonSerializable(explicitToJson: true)
  const factory ReplyForm({
    String? uid,
    @Default("") String templateUID,
    @Default("") String templateVersion,
    @Default("") String accountUID,
    @Default("") String createdAt,
    @Default("") String updatedAt,
    @Default("") String assigneeUID,
    @Default("") String entityType,
    @Default("") String entityUID,
    @Default("") String visibleFor,
    @Default("") String replyStatus,
    @Default(<Reply>[]) List<Reply> replies,
  }) = _ReplyForm;

  factory ReplyForm.fromJson(Map<String, dynamic> json) => _$ReplyFormFromJson(json);

  bool get readOnly => replyStatus.trim().isNotEmpty && replyStatus != 'RETURNED' && replyStatus != 'IN_PROGRESS';
}
