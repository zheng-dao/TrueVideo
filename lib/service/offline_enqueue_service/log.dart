import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import '_interface_item.dart';

class OfflineEnqueueLogServiceImpl extends OfflineEnqueueItemService {
  LogEventService get _logService => GetIt.I.get();

  OfflineEnqueueService get _offlineEnqueueService => GetIt.I.get();

  LocalDatabaseService get _localDatabaseService => GetIt.I.get();

  String get _boxName => "offline-enqueue-items";

  @override
  Future<void> onDelete(String uid) async {}

  @override
  Future<void> onDone(String uid) async {
    await _localDatabaseService.delete(_boxName, uid);
  }

  @override
  Future<void> onError(String uid, error) async {}

  @override
  Future<void> onPending(String uid) async {}

  @override
  Future<void> onProcess(String uid) async {
    final request = await _offlineEnqueueService.getByUID(uid);
    if (request == null) return;

    final data = request.data ?? <String, dynamic>{};

    await _logService.processLog(
      LogEventModule.values[data["moduleIndex"]],
      message: data["message"] ?? "",
      level: LogEventLevel.values[data["levelIndex"]],
      raw: data["raw"] ?? "",
      action: data["action"] ?? "",
      orderID: data["orderID"],
    );

    log("Item end process.  $uid");
  }

  @override
  Future<void> onRetry(String uid) async {}
}
