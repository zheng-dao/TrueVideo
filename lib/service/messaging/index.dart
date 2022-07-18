import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/message_authentication_information.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/message_member.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_chat.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import '_interface.dart';

class MessagingServiceImpl extends MessagingService {
  final String baseURL;

  MessagingServiceImpl({
    required this.baseURL,
  });

  @override
  Future<MessageAuthenticationInformationModel?> getCachedAuthenticationInformation() async {
    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    final cached = await localDatabaseService.read("authentication-information", "data");
    if (cached == null) return null;
    try {
      return MessageAuthenticationInformationModel.fromJson(jsonDecode(jsonEncode(cached)));
    } catch (error, stack) {
      log("Error parsing cached MessageAuthenticationInformationModel", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<MessageAuthenticationInformationModel?> authenticate() async {
    final HttpService httpService = GetIt.I.get();
    final LocalDatabaseService localDatabaseService = GetIt.I.get();

    final AuthService service = GetIt.I.get();
    final token = await service.token;
    if (token == null || token.trim().isEmpty) {
      throw CustomException();
    }

    final result = await httpService.get(
      Uri.parse("$baseURL/api/profile/me"),
      headers: {
        "x-authorization-truvideo": token,
      },
    );

    try {
      final model = MessageAuthenticationInformationModel.fromJson(result.data as Map<String, dynamic>);
      await localDatabaseService.write("authentication-information", "data", model.toJson());
      return model;
    } catch (error, stack) {
      log("Error parsing MessageAuthenticationInformationModel", error: error, stackTrace: stack);
      await localDatabaseService.delete("authentication-information", "data");
      return null;
    }
  }

  @override
  Future<List<MessageMemberModel>> getMembersPaginated({
    required String accountUID,
    bool onlyReplied = false,
    int pageLength = 10,
    int page = 0,
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;
    final applicationUid = service.applicationUid;
    final sub = service.sub ?? "";

    final result = await httpService.post(
      Uri.parse("$baseURL/api/members/search"),
      headers: {
        "x-authorization-truvideo": token,
      },
      data: {
        "onlyReplied": onlyReplied,
        "pagination": {
          "pageNum": page,
          "pageSize": pageLength,
        },
        "accountUID": accountUID,
        "applicationUID": applicationUid,
      },
    );

    final items = (result.data! as List<dynamic>).map((e) => MessageMemberModel.fromJson(e as Map<String, dynamic>)).toList();
    if (page == 0) {
      // Cache items
      final LocalDatabaseService localDatabaseService = GetIt.I.get();
      await localDatabaseService.write("message-members-cache", sub, jsonEncode(items.map((e) => e.toJson()).toList()));
    }

    return items;
  }

  @override
  Future<List<MessageMemberModel>> getCachedMembers() async {
    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    final AuthService authService = GetIt.I.get();
    final sub = authService.sub ?? "";

    final data = await localDatabaseService.read("message-members-cache", sub);
    if (data == null) {
      return [];
    }

    return (jsonDecode(data.toString()) as List<dynamic>)
        .map((e) {
          try {
            return MessageMemberModel.fromJson(e as Map<String, dynamic>);
          } catch (error) {
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Future<List<MessageModel>> getMessages({
    required String accountUID,
    required String memberUID,
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;
    final sub = service.sub ?? "";

    final result = await httpService.post(
      Uri.parse("$baseURL/api/message/search"),
      headers: {
        "x-authorization-truvideo": token,
      },
      data: {
        "accountUID": accountUID,
        "memberUID": memberUID,
      },
    );

    final items = (result.data! as List<dynamic>).map((e) => MessageModel.fromJson(e as Map<String, dynamic>)).toList();
    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    final offlineItems = await offlineEnqueueService.getAll(type: [OfflineEnqueueItemType.chat]);

    for (var item in items) {
      final deleteItems = offlineItems.where((e) {
        try {
          final data = OfflineEnqueueItemChatModel.fromJson(e.data ?? <String, dynamic>{});
          if (data.auxUID == "") return false;
          if (item.auxUID == "") return false;
          return data.auxUID == item.auxUID;
        } catch (error) {
          return true;
        }
      }).toList();

      for (var element in deleteItems) {
        await offlineEnqueueService.delete(element.uid);
      }
    }

    // Cache items
    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    await localDatabaseService.write("messages-cache", "${sub}_$memberUID", jsonEncode(items.map((e) => e.toJson()).toList()));

    return items;
  }

  @override
  Future<List<MessageModel>> getCachedMessages({required String memberUID}) async {
    final AuthService service = GetIt.I.get();
    final sub = service.sub ?? "";

    final LocalDatabaseService localDatabaseService = GetIt.I.get();

    final data = await localDatabaseService.read("messages-cache", "${sub}_$memberUID");
    if (data == null) {
      return [];
    }

    final items = (jsonDecode(data.toString()) as List<dynamic>)
        .map((e) {
          try {
            return MessageModel.fromJson(e as Map<String, dynamic>);
          } catch (error) {
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();

    return items;
  }

  @override
  Future<MessageModel> createMessage({
    required String channelUID,
    required String accountUID,
    required String message,
    String auxUID = "",
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService authService = GetIt.I.get();
    final token = authService.token;

    final result = await httpService.post(
      Uri.parse("$baseURL/api/message/send"),
      headers: {
        "x-authorization-truvideo": token,
      },
      data: {
        "channelUID": channelUID,
        "accountUID": accountUID,
        "message": message,
        "auxUID": auxUID,
      },
    );

    final model = MessageModel.fromJson(result.data as Map<String, dynamic>);
    return model;
  }

  @override
  Future<void> deleteChannels(List<String> uuids) async {
    throw UnimplementedError();
  }

  @override
  Future<void> markAsArchived(List<String> uuids, bool archived) async {
    throw UnimplementedError();
  }

  @override
  Future<void> markAsFavorite(List<String> uuids, bool favorite) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMessages(List<String> uuids) async {
    throw UnimplementedError();
  }

  @override
  Future<MessageChannelModel?> getChannelByUid(String uid) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;
    final accountUid = service.accountUid;

    final result = await httpService.post(
      Uri.parse("$baseURL/api/getChannel"),
      headers: {
        "x-authorization-truvideo": token,
      },
      data: {
        "accountUID": accountUid,
        "channelUID": uid,
      },
    );

    try {
      final model = MessageChannelModel.fromJson(result.data as Map<String, dynamic>);

      final LocalDatabaseService localDatabaseService = GetIt.I.get();
      await localDatabaseService.write("cached-messaging-channel", uid, model.toJson());

      return model;
    } catch (error, stack) {
      log("Error parsing MessageChannelModel.", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Stream<MessageChannelModel?> streamChannelByUid(String uid) {
    final streamController = StreamController<MessageChannelModel?>.broadcast();

    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    localDatabaseService.read("cached-messaging-channel", uid).then((value) {
      if (value != null) {
        try {
          final model = MessageChannelModel.fromJson(jsonDecode(jsonEncode(value)));
          streamController.add(model);
        } catch (error, stack) {
          log("Error parsing MessageChannelModel", error: error, stackTrace: stack);
        }
      }

      getChannelByUid(uid)
        ..then((value) {
          streamController.add(value);
        })
        ..catchError((error) {
          streamController.addError(error);
        });
    });

    return streamController.stream;
  }
}
