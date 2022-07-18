import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_chat.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface_item.dart';

class OfflineEnqueueChatServiceImpl extends OfflineEnqueueItemService {
  String get _boxName => "offline-enqueue-items";

  Future<List<OfflineEnqueueItemModel>> _getAllItems() async {
    final LocalDatabaseService localDatabaseService = GetIt.I.get();

    final items = await localDatabaseService.getAll(_boxName);

    return items
        .map((e) {
          try {
            return OfflineEnqueueItemModel.fromJson(jsonDecode(jsonEncode(e)));
          } catch (error) {
            log("Error parsing item model");
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  Future<OfflineEnqueueItemModel?> _getByUid(String uid) async {
    final items = (await _getAllItems()).where((element) => element.uid == uid).toList();
    if (items.isEmpty) return null;
    return items[0];
  }

  Future<OfflineEnqueueItemModel> _update(String uid, OfflineEnqueueItemModel model) async {
    final updatedModel = model.copyWith(updatedAt: DateTime.now());
    final LocalDatabaseService localDatabaseService = GetIt.I.get();
    await localDatabaseService.write(_boxName, uid, updatedModel.toJson());
    return updatedModel;
  }

  @override
  Future<void> onDone(String uid) async {}

  @override
  Future<void> onError(String uid, dynamic error) async {}

  @override
  Future<void> onPending(String uid) async {}

  @override
  Future<void> onProcess(String uid) async {
    final model = await _getByUid(uid);
    if (model == null) return;

    await Future.delayed(const Duration(milliseconds: 500));

    final data = OfflineEnqueueItemChatModel.fromJson(model.data ?? <String, dynamic>{});
    final MessagingService messagingService = GetIt.I.get();
    final createdModel = await messagingService.createMessage(
      channelUID: data.channelUID,
      accountUID: data.accountUID,
      message: data.text,
      auxUID: data.auxUID,
    );

    await _update(
      uid,
      model.copyWith(result: createdModel.toJson()),
    );
  }

  @override
  Future<void> onDelete(String uid) async {}

  @override
  Future<void> onRetry(String uid) async {}
}
