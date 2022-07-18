import 'package:truvideo_enterprise/model/checklist/reply/reply_form/reply_form.dart';
import 'package:truvideo_enterprise/model/checklist/template/template.dart';
import 'package:truvideo_enterprise/model/checklist/template_reply/template_reply.dart';

enum ChecklistStatus {
  noExisting,
  existing,
  existingResume,
  existingReturned,
}

abstract class ChecklistService {
  Future<List<Template>> getTemplates();

  Future<Template?> getTemplateByUID(String templateUID);

  Future<String?> saveTemplateReply(dynamic data);

  Future<String?> updateTemplateReply(String templateUID, dynamic data);

  Future<List<ReplyForm>> getTemplateReplyByEntity(String jobServiceNumber);

  Future<TemplateReply> getTemplateReplyByReplyID(String replyID);

  Future<ChecklistStatus> getStatus(String jobServiceNumber);

  Future<void> cacheStatus(String jobServiceNumber, ChecklistStatus status);

  Future<ChecklistStatus?> getCachedStatus(String jobServiceNumber);
}
