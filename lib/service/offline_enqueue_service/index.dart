import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import '_interface_item.dart';

class OfflineEnqueueServiceImpl extends OfflineEnqueueService {
  OfflineEnqueueServiceImpl();
  bool _serviceRunning = false;

  String get _boxName => "offline-enqueue-items";

  LocalDatabaseService get _localDatabaseService => GetIt.I.get();

  @override
  Future<void> startService() async {
    log("Start service.");

    final ConnectivityService connectivityService = GetIt.I.get();

    if (_serviceRunning) {
      log("The offline service is already running");
      return;
    }

    if (await (connectivityService.isOffline())) {
      log("The device is offline. Stopping service");
      _serviceRunning = false;
      return;
    }

    _serviceRunning = true;

    try {
      // Chang processing to pending
      var processing = await _getByStatus([OfflineEnqueueItemStatus.processing]);
      if (processing.isNotEmpty) {
        log("Change ${processing.length} processing items to pending");
        for (var item in processing) {
          try {
            await _changeStatus(item.uid, OfflineEnqueueItemStatus.pending);
          } catch (error, stack) {
            log("Item error ${item.uid}", error: error, stackTrace: stack);
            await _incrementError(item.uid, error: error);
          }

          if (!_serviceRunning) {
            return;
          }
        }
      }

      // Fetch all pending items
      var pending = await _getByStatus([OfflineEnqueueItemStatus.pending]);
      if (pending.isEmpty) {
        log("No pending items");
        _serviceRunning = false;
        return;
      }

      log("${pending.length} items pending to process");

      // Process each item
      for (var model in pending) {
        try {
          log("Process ${model.uid}");
          await _changeStatus(model.uid, OfflineEnqueueItemStatus.processing);
          log("Change to done ${model.uid}");
          await _changeStatus(model.uid, OfflineEnqueueItemStatus.done);
          log("Ready ${model.uid}");
        } catch (error, stack) {
          log("Item error ${model.uid}", error: error, stackTrace: stack);
          await _incrementError(model.uid, error: error);
        }

        if (!_serviceRunning) {
          return;
        }
      }
    } catch (error, stack) {
      log("Global error", error: error, stackTrace: stack);
    }

    _serviceRunning = false;
    Future.delayed(const Duration(seconds: 5));
    startService();
  }

  Future<List<OfflineEnqueueItemModel>> _getByStatus(List<OfflineEnqueueItemStatus> status) async {
    final items = await _getAllItems();
    return items.where((e) => status.contains(e.status)).toList();
  }

  Future<OfflineEnqueueItemModel> _update(String uid, OfflineEnqueueItemModel model) async {
    final updatedModel = model.copyWith(updatedAt: DateTime.now());
    await _localDatabaseService.write(_boxName, uid, updatedModel.toJson());
    return updatedModel;
  }

  Future<List<OfflineEnqueueItemModel>> _getAllItems() async {
    final items = await _localDatabaseService.getAll(_boxName);

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

  Future<void> _changeStatus(
    String uid,
    OfflineEnqueueItemStatus status, {
    String? errorMessage,
  }) async {
    final model = await getByUID(uid);
    if (model == null) throw CustomException(message: "Item not found");
    if (model.status == status) return;

    var updatedModel = model. copyWith(
      statusIndex: status.index,
      errorMessage: status == OfflineEnqueueItemStatus.error ? (errorMessage ?? "") : "",
    );
    await _update(uid, updatedModel);

    if (!GetIt.I.isRegistered<OfflineEnqueueItemService>(instanceName: model.type.eventKey)) {
      throw CustomException(message: "Cant find implementation to type ${model.type.eventKey}");
    }

    final OfflineEnqueueItemService itemService = GetIt.I.get<OfflineEnqueueItemService>(instanceName: model.type.eventKey);

    log("Process ${model.type.eventKey} with ${itemService.runtimeType}");

    switch (status) {
      case OfflineEnqueueItemStatus.pending:
        await itemService.onPending(uid);
        break;
      case OfflineEnqueueItemStatus.processing:
        await itemService.onProcess(uid);
        break;
      case OfflineEnqueueItemStatus.done:
        await itemService.onDone(uid);
        break;
      case OfflineEnqueueItemStatus.error:
        await itemService.onError(uid, errorMessage);
        break;
    }
  }

  Future<void> _incrementError(
    String uid, {
    dynamic error,
  }) async {
    try {
      var model = await getByUID(uid);
      if (model == null) throw CustomException(message: "Item not found");

      var retryCount = model.retryCount;
      var maxRetryCount = model.maxRetryCount;

      if (retryCount >= maxRetryCount) {
        log("IncrementError | Mark error ${model.uid}");
        await _update(uid, model.copyWith(retryCount: 0));

        String errorMessage = "";
        if (error != null && error is CustomException) {
          errorMessage = error.message ?? "";
        }

        await _changeStatus(model.uid, OfflineEnqueueItemStatus.error, errorMessage: errorMessage);
      } else {
        final newCounter = model.retryCount + 1;
        log("IncrementError | Increment retry counter for item UID: ${model.uid} to counter: $newCounter");
        await _update(
          uid,
          model.copyWith(retryCount: newCounter, errorMessage: ""),
        );
      }
    } catch (error, stack) {
      log("Error incrementing error.", error: error, stackTrace: stack);
    }
  }

  @override
  Future<OfflineEnqueueItemModel> enqueue(OfflineEnqueueItemModel model) async {
    model = model.copyWith(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      statusIndex: OfflineEnqueueItemStatus.pending.index,
      errorMessage: "",
      retryCount: 0,
      updatedAt: null,
      startAt: null,
      endAt: null,
      maxRetryCount: 5,
    );

    await _localDatabaseService.write(_boxName, model.uid, model.toJson());
    startService();
    return model;
  }

  @override
  Future<void> update(OfflineEnqueueItemModel model) async {
    final current = await getByUID(model.uid);
    if (current == null) return;
    await _update(model.uid, model);
  }

  @override
  Future<void> delete(String uid) async {
    final model = await getByUID(uid);
    if (model == null) throw CustomException(message: "Item not found");

    final OfflineEnqueueItemService itemService = GetIt.I.get(instanceName: model.type.eventKey);
    await itemService.onDelete(uid);
    await _localDatabaseService.delete(_boxName, uid);
    startService();
  }

  @override
  Future<void> retry(String uid) async {
    final model = await getByUID(uid);
    if (model == null) throw CustomException(message: "Item not found");

    await _update(uid, model.copyWith(retryCount: 0, errorMessage: ""));
    await _changeStatus(uid, OfflineEnqueueItemStatus.pending);
    startService();
  }

  @override
  Stream<List<OfflineEnqueueItemModel>> stream({
    List<OfflineEnqueueItemType> type = const <OfflineEnqueueItemType>[],
    List<OfflineEnqueueItemStatus> status = const <OfflineEnqueueItemStatus>[],
  }) {
    return _localDatabaseService.streamAll(_boxName).map((event) => event
        .map((e) {
          try {
            return OfflineEnqueueItemModel.fromJson(jsonDecode(jsonEncode(e)));
          } catch (error) {
            return null;
          }
        })
        .where((element) {
          if (element == null) return false;

          bool withType = true;
          bool withStatus = true;

          if (type.isNotEmpty) {
            withType = type.contains(element.type);
          }

          if (status.isNotEmpty) {
            withStatus = status.contains(element.status);
          }

          return withType && withStatus;
        })
        .map((e) => e!)
        .toList());
  }

  @override
  Future<List<OfflineEnqueueItemModel>> getAll({
    List<OfflineEnqueueItemType> type = const <OfflineEnqueueItemType>[],
    List<OfflineEnqueueItemStatus> status = const <OfflineEnqueueItemStatus>[],
  }) async {
    final items = await _localDatabaseService.getAll(_boxName);
    return items
        .map((e) {
          try {
            return OfflineEnqueueItemModel.fromJson(jsonDecode(jsonEncode(e)));
          } catch (error) {
            return null;
          }
        })
        .where((element) {
          if (element == null) return false;

          bool withType = true;
          bool withStatus = true;

          if (type.isNotEmpty) {
            withType = type.contains(element.type);
          }

          if (status.isNotEmpty) {
            withStatus = status.contains(element.status);
          }

          return withType && withStatus;
        })
        .map((e) => e!)
        .toList();
  }

  @override
  Future<OfflineEnqueueItemModel?> getByUID(String uid) async {
    final value = await _localDatabaseService.read(_boxName, uid);
    if (value == null) return null;

    try {
      return OfflineEnqueueItemModel.fromJson(jsonDecode(jsonEncode(value)));
    } catch (error) {
      log("Error parsing OfflineEnqueueItemModel", error: error);
      return null;
    }
  }

  @override
  Stream<OfflineEnqueueItemModel?> streamByUID(String uid) {
    return _localDatabaseService.streamByKey(_boxName, uid).map((event) {
      if (event == null) return null;
      try {
        return OfflineEnqueueItemModel.fromJson(jsonDecode(jsonEncode(event)));
      } catch (error) {
        log("Error parsing OfflineEnqueueItemModel", error: error);
        return null;
      }
    });
  }
}
