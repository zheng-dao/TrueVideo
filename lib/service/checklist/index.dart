import 'dart:async';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/model/checklist/reply/reply_form/reply_form.dart';
import 'package:truvideo_enterprise/model/checklist/template/template.dart';
import 'package:truvideo_enterprise/model/checklist/template_reply/template_reply.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';

import '_interface.dart';

class ChecklistServiceImpl extends ChecklistService {
  final String securityToken;
  final String baseURL;
  final String authorizationHeader = "X-Authorization-TruVideo";

  HttpService get _httpService => GetIt.I.get();

  AuthService get _authService => GetIt.I.get();

  ConnectivityService get _connectivityService => GetIt.I.get();

  LocalDatabaseService get _localDatabaseService => GetIt.I.get();

  String _getCachedStatusBoxName({
    required String userUID,
    required String dealerCode,
  }) =>
      "cached-checklist-status-$dealerCode-$userUID";

  ChecklistServiceImpl({
    required this.baseURL,
    required this.securityToken,
  });

  @override
  Future<List<Template>> getTemplates() async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.get(
      Uri.parse("$baseURL/api/v1/$accountUID/templates?category=CHECKLIST&subCategory=AUTOMOTIVE&templateStatus=PUBLISHED"),
      headers: {
        authorizationHeader: token,
      },
    );
    final data = (response.data as dynamic);
    return ((data["templates"] as List).map((e) {
      return Template.fromJson(e as Map<String, dynamic>);
    }).toList());
  }

  @override
  Future<Template?> getTemplateByUID(String templateUID) async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.get(
      Uri.parse("$baseURL/api/v1/$accountUID/templates/$templateUID"),
      headers: {
        authorizationHeader: token,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return Template.fromJson(data["template"]);
  }

  @override
  Future<String?> saveTemplateReply(dynamic data) async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.post(
      Uri.parse("$baseURL/api/v1/$accountUID/replies"),
      headers: {
        authorizationHeader: token,
      },
      data: data,
    );
    String templateReplyUID = '';
    final dataResponse = response.data as Map<String, dynamic>;
    templateReplyUID = dataResponse['replyUID'];
    return templateReplyUID;
  }

  @override
  Future<String?> updateTemplateReply(String templateUID, dynamic data) async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.put(
      Uri.parse("$baseURL/api/v1/$accountUID/replies/$templateUID"),
      headers: {
        authorizationHeader: token,
      },
      data: data,
    );
    return response.toString();
  }

  @override
  Future<List<ReplyForm>> getTemplateReplyByEntity(String jobServiceNumber) async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.get(
      Uri.parse("$baseURL/api/v1/$accountUID/replies/entities/REPAIR_ORDER/$jobServiceNumber"),
      headers: {
        authorizationHeader: token,
      },
    );

    final data = (response.data as dynamic);
    final result = ((data["replies"] as List).map((e) {
      return ReplyForm.fromJson(e as Map<String, dynamic>);
    }).toList());

    return result;
  }

  @override
  Future<TemplateReply> getTemplateReplyByReplyID(String replyID) async {
    await _connectivityService.validateOnline();

    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    final response = await _httpService.get(
      Uri.parse("$baseURL/api/v1/$accountUID/replies/$replyID"),
      headers: {
        authorizationHeader: token,
      },
    );
    return TemplateReply.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> cacheStatus(String jobServiceNumber, ChecklistStatus status) async {
    final boxName = _getCachedStatusBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );
    await _localDatabaseService.write(
      boxName,
      jobServiceNumber,
      status.index.toString(),
    );
  }

  @override
  Future<ChecklistStatus?> getCachedStatus(String jobServiceNumber) async {
    final boxName = _getCachedStatusBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    final value = await _localDatabaseService.read(boxName, jobServiceNumber);
    if (value == null || value.toString().trim().isEmpty) return null;

    try {
      return ChecklistStatus.values[int.parse(value)];
    } catch (error) {
      log("EError parsing ChecklistStatus", error: error);
      return null;
    }
  }

  @override
  Future<ChecklistStatus> getStatus(String jobServiceNumber) async {
    await _connectivityService.validateOnline();

    final replyForms = await getTemplateReplyByEntity(jobServiceNumber);

    if (replyForms.isEmpty) return ChecklistStatus.noExisting;

    final current = replyForms.first;
    if ((current.uid ?? "").trim().isEmpty) return ChecklistStatus.noExisting;

    final templateReply = await getTemplateReplyByReplyID(current.uid!);
    final currentReplyForm = templateReply.reply;

    final isReplyFormEmpty = (currentReplyForm.uid?.trim() ?? "").isEmpty;
    if (isReplyFormEmpty) {
      return ChecklistStatus.noExisting;
    }

    final inProgress = currentReplyForm.replyStatus == "IN_PROGRESS";
    if (inProgress) {
      return ChecklistStatus.existingResume;
    }

    final returned = currentReplyForm.replyStatus == "RETURNED";
    if (returned) {
      return ChecklistStatus.existingReturned;
    }

    return ChecklistStatus.existing;
  }
}
