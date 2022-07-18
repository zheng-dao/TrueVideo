import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/model/camera/camera_picture_file.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_ro_video_upload.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/model/pagination.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/local_db/_interface.dart';
import 'package:truvideo_enterprise/service/log_event/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';

import '_interface.dart';
import 'dto/video_upload.dart';

class RepairOrderServiceImpl extends RepairOrderService {
  final String baseURL;

  AuthService get _authService => GetIt.I.get();

  HttpService get _httpService => GetIt.I.get();

  LocalDatabaseService get _localDatabaseService => GetIt.I.get();

  OfflineEnqueueService get _offlineEnqueueService => GetIt.I.get();

  LogEventService get _logEventService => GetIt.I.get();

  RepairOrderServiceImpl({required this.baseURL});

  String _getCachedRepairOrderListBoxName({
    required String userUID,
    required String dealerCode,
  }) =>
      "cached-repair-orders-$dealerCode-$userUID";

  String _getCachedRepairOrderDetailBoxName({
    required String userUID,
    required String dealerCode,
  }) =>
      "cached-repair-order-detail-$dealerCode-$userUID";

  String _getUploadRequestsBoxName({
    required String userUID,
    required String dealerCode,
  }) =>
      "upload-requests-$dealerCode-$userUID";

  @override
  Future<PaginationModel<RepairOrderModel>> getList({
    int page = 1,
    int pageSize = 20,
    int? id,
    RepairOrderTypeFilter type = RepairOrderTypeFilter.all,
    String filterBy = "",
    String query = "",
  }) async {
    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    String currentType = "";
    switch (type) {
      case RepairOrderTypeFilter.all:
        currentType = "";
        break;
      case RepairOrderTypeFilter.repairOrders:
        currentType = "REPAIR_ORDER";
        break;
      case RepairOrderTypeFilter.salesOrders:
        currentType = "SALES_ORDER";
        break;
    }

    final result = await _httpService.get(
      Uri.parse("$baseURL/api/v3/repair-order"),
      headers: {
        "x-authorization-truvideo": token,
      },
      params: {
        "account-uid": accountUID,
        "p": page,
        "pageSize": pageSize.toString(),
        if (id != null) "id": id,
        if (currentType.trim().isNotEmpty) "type": currentType,
        if (filterBy.trim().isNotEmpty) "filterBy": filterBy,
        if (query.trim().isNotEmpty) "query": query,
      },
    );

    if (result.data == null) {
      return PaginationModel<RepairOrderModel>(
        data: const [],
        hasMore: false,
        page: page + 1,
        pageSize: pageSize,
      );
    }

    final total = (result.data! as Map)["totalResults"];
    final currentPage = (result.data! as Map)["currPage"];

    final items = ((result.data! as Map)['results'] as List<dynamic>)
        .map((e) {
          try {
            return RepairOrderModel.fromJson(e as Map<String, dynamic>);
          } catch (error) {
            log("Error parsing RepairOrderModel", error: error);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();

    bool hasMore = (((currentPage - 1) * pageSize) + items.length) < total;

    return PaginationModel<RepairOrderModel>(
      data: items,
      pageSize: pageSize,
      page: currentPage,
      total: total,
      hasMore: hasMore,
    );
  }

  @override
  Future<void> setCacheList({
    String status = "",
    required List<RepairOrderModel> items,
  }) async {
    final dealerCode = _authService.getStoredDealerCode();
    final boxName = _getCachedRepairOrderListBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: dealerCode,
    );
    var key = status;
    final value = jsonEncode(items.map((e) => e.toJson()).toList());

    await _localDatabaseService.write(
      boxName,
      key,
      value,
    );
  }

  @override
  Future<void> updateCacheList(RepairOrderModel item) async {
    final boxName = _getCachedRepairOrderListBoxName(
      dealerCode: _authService.getStoredDealerCode(),
      userUID: _authService.sub ?? "",
    );
    final keys = await _localDatabaseService.getAllKeys(boxName);

    for (var status in keys) {
      var items = await getCachedList(status: status);

      items = items.map((e) {
        if (e.id == item.id) return item;
        return e;
      }).toList();

      await setCacheList(status: status, items: items);
    }
  }

  @override
  Future<List<RepairOrderModel>> getCachedList({String status = ""}) async {
    final boxName = _getCachedRepairOrderListBoxName(
      dealerCode: _authService.getStoredDealerCode(),
      userUID: _authService.sub ?? "",
    );
    var key = status;
    final data = await _localDatabaseService.read(boxName, key);
    if (data == null) {
      return [];
    }

    return (jsonDecode(data.toString()) as List<dynamic>)
        .map((e) {
          try {
            return RepairOrderModel.fromJson(e);
          } catch (error) {
            log("Error parsing cached RepairOrderMode", error: error);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Future<RepairOrderDetailModel?> getDetail(int id) async {
    final token = await _authService.token;
    final accountUID = _authService.accountUid;
    final boxName = _getCachedRepairOrderDetailBoxName(
      dealerCode: _authService.getStoredDealerCode(),
      userUID: _authService.sub ?? "",
    );

    final result = await _httpService.get(
      Uri.parse("$baseURL/api/v3/repair-order/$id?account-uid=$accountUID"),
      headers: {
        "x-authorization-truvideo": token,
      },
    );

    try {
      if (result.data != null) {
        final model = RepairOrderDetailModel.fromJson(result.data! as Map<String, dynamic>);
        await _localDatabaseService.write(boxName, id.toString(), model.toJson());
        return model;
      } else {
        await _localDatabaseService.delete(boxName, id.toString());
        return null;
      }
    } catch (error) {
      log("Error parsing RepairOrderDetailModel", error: error);
      return null;
    }
  }

  @override
  Future<RepairOrderDetailModel?> getCachedDetail(int id) async {
    final boxName = _getCachedRepairOrderDetailBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );
    final cached = await _localDatabaseService.read(boxName, id.toString());
    if (cached == null) return null;
    try {
      return RepairOrderDetailModel.fromJson(jsonDecode(jsonEncode(cached)));
    } catch (error, stack) {
      log("Error parsing cached RepairOrderDetailModel", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<RepairOrderUploadVideoRequestModel> addVideoUploadRequest({
    required int orderID,
    required String orderType,
    required CameraResultModel cameraResult,
    String tagId = "",
    String typeId = "",
    String description = "",
  }) async {
    _logEventService.logEvent(
      LogEventModule.videoUpload,
      orderID: orderID,
      action: LogEventActionVideoUpload.create.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({
        "videoPath": cameraResult.video.info.path,
        "pictures": cameraResult.pictures.map((e) => e.path).toList(),
        "tagID": tagId,
        "typeId": typeId,
        "description": description,
      }),
    );

    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    final model = RepairOrderUploadVideoRequestModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      orderID: orderID,
      orderType: orderType,
      cameraResult: cameraResult,
      offlineEnqueueUID: '',
      creationDate: DateTime.now(),
      videoTagID: tagId,
      videoTypeID: typeId,
      videoDescription: description,
    );

    try {
      await _localDatabaseService.write(
        boxName,
        model.uid,
        model.toJson(),
      );

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: orderID,
        action: LogEventActionVideoUpload.create.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "videoPath": cameraResult.video.info.path,
          "pictures": cameraResult.pictures.map((e) => e.path).toList(),
          "tagID": tagId,
          "typeId": typeId,
          "description": description,
        }),
      );

      return model;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: orderID,
        action: LogEventActionVideoUpload.create.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "videoPath": cameraResult.video.info.path,
          "pictures": cameraResult.pictures.map((e) => e.path).toList(),
          "tagID": tagId,
          "typeId": typeId,
          "description": description,
        }),
      );

      rethrow;
    }
  }

  @override
  Future<List<RepairOrderUploadVideoRequestModel>> getVideoUploadRequests({required int orderID}) async {
    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    final info = await _localDatabaseService.getAll(boxName);

    if (info.isEmpty) {
      return [];
    }

    return info
        .map((e) {
          try {
            return RepairOrderUploadVideoRequestModel.fromJson(jsonDecode(jsonEncode(e)));
          } catch (error) {
            log("Error parsing cached RepairOrderUploadVideoRequestModel", error: error);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Stream<List<RepairOrderUploadVideoRequestModel>> streamVideoUploadRequests({required int orderID}) {
    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    return _localDatabaseService.streamAll(boxName).map((event) {
      return event
          .map((e) {
            try {
              final model = RepairOrderUploadVideoRequestModel.fromJson(jsonDecode(jsonEncode(e)));
              if (model.orderID != orderID) {
                return null;
              }
              return model;
            } catch (error, stack) {
              log("Error parsing RepairOrderUploadVideoRequestModel", error: error, stackTrace: stack);
              return null;
            }
          })
          .where((element) => element != null)
          .map((e) => e!)
          .toList();
    });
  }

  @override
  Future<RepairOrderUploadVideoRequestModel?> getVideoUploadRequestByUID(String uid) async {
    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    final data = await _localDatabaseService.read(boxName, uid);
    if (data == null) return null;

    try {
      return RepairOrderUploadVideoRequestModel.fromJson(jsonDecode(jsonEncode(data)));
    } catch (error) {
      log("Error parsing cached RepairOrderUploadVideoRequestModel", error: error);
      return null;
    }
  }

  @override
  Future<RepairOrderUploadVideoRequestModel?> updateVideoUploadRequest(RepairOrderUploadVideoRequestModel model) async {
    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    _logEventService.logEvent(
      LogEventModule.videoUpload,
      orderID: model.orderID,
      action: LogEventActionVideoUpload.edit.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({
        "videoPath": model.cameraResult?.video.info.path ?? "",
        "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
        "tagID": model.videoTagID,
        "typeId": model.videoTypeID,
        "description": model.videoDescription,
      }),
    );

    try {
      await _localDatabaseService.write(
        boxName,
        model.uid,
        model.toJson(),
      );

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.edit.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );

      return model;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.edit.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );

      rethrow;
    }
  }

  @override
  Stream<RepairOrderUploadVideoRequestModel?> streamVideoUploadRequestByUID(String uid) {
    final boxName = _getUploadRequestsBoxName(
      userUID: _authService.sub ?? "",
      dealerCode: _authService.getStoredDealerCode(),
    );

    return _localDatabaseService.streamByKey(boxName, uid).map((event) {
      if (event == null) return null;
      try {
        return RepairOrderUploadVideoRequestModel.fromJson(jsonDecode(jsonEncode(event)));
      } catch (error, stack) {
        log("Error parsing RepairOrderUploadVideoRequestModel", error: error, stackTrace: stack);
        return null;
      }
    });
  }

  @override
  Future<void> startVideoUploadRequest(String uid) async {
    final model = await getVideoUploadRequestByUID(uid);
    if (model == null) return;

    if (model.offlineEnqueueUID.trim().isNotEmpty) {
      return retryVideoUploadRequest(uid);
    }

    final offlineEnqueueItem = await _offlineEnqueueService.enqueue(
      OfflineEnqueueItemModel(
        typeIndex: OfflineEnqueueItemType.repairOrderVideoUpload.index,
        data: OfflineEnqueueItemRepairOrderVideoUploadModel(videoUploadRequestUID: uid).toJson(),
      ),
    );

    await updateVideoUploadRequest(model.copyWith(offlineEnqueueUID: offlineEnqueueItem.uid));
  }

  @override
  Future<void>  retryVideoUploadRequest(String uid) async {
    final model = await getVideoUploadRequestByUID(uid);
    if (model == null) {
      throw CustomException(message: "Video upload request not found");
    }

    try {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.retry.eventName,
        level: LogEventLevel.info,
        raw: jsonEncode({
          "uid": uid,
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );

      if (model.offlineEnqueueUID.trim().isEmpty) {
        throw CustomException(message: "The video upload request has not started");
      }

      final offlineEnqueueItem = await _offlineEnqueueService.getByUID(model.offlineEnqueueUID);
      if (offlineEnqueueItem == null) {
        await updateVideoUploadRequest(model.copyWith(offlineEnqueueUID: ""));
        return startVideoUploadRequest(uid);
      }

      if (offlineEnqueueItem.status != OfflineEnqueueItemStatus.error) {
        throw CustomException(message: "Invalid video upload request state");
      }

      await _offlineEnqueueService.retry(model.offlineEnqueueUID);

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.retry.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "uid": uid,
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.retry.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "uid": uid,
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );

      rethrow;
    }
  }

  @override
  Future<void> deleteVideoUploadRequest(String uid) async {
    final model = await getVideoUploadRequestByUID(uid);
    if (model == null) return;

    _logEventService.logEvent(
      LogEventModule.videoUpload,
      orderID: model.orderID,
      action: LogEventActionVideoUpload.delete.eventName,
      level: LogEventLevel.info,
      raw: jsonEncode({
        "uid": uid,
        "videoPath": model.cameraResult?.video.info.path ?? "",
        "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
        "tagID": model.videoTagID,
        "typeId": model.videoTypeID,
        "description": model.videoDescription,
      }),
    );

    // Offline enqueue

    try {
      if (model.offlineEnqueueUID.trim().isNotEmpty) {
        final offlineEnqueue = await _offlineEnqueueService.getByUID(model.offlineEnqueueUID);
        if (offlineEnqueue != null) {
          final validStatusForDelete = [OfflineEnqueueItemStatus.error, OfflineEnqueueItemStatus.done, OfflineEnqueueItemStatus.pending];
          if (!validStatusForDelete.contains(offlineEnqueue.status)) {
            throw CustomException(message: "You cant delete an upload request in progress");
          }

          await _offlineEnqueueService.delete(model.offlineEnqueueUID);
        }
      }

      // Delete video
      if (model.cameraResult?.video != null) {
        CustomFileUtils.delete(model.cameraResult?.video.info.path ?? "");
        CustomFileUtils.delete(model.cameraResult?.video.thumbnailPath ?? "");
      }

      // Delete images
      for (var e in (model.cameraResult?.pictures ?? <CameraPictureFileModel>[])) {
        CustomFileUtils.delete(e.path);
      }

      // Remove item
      final boxName = _getUploadRequestsBoxName(
        userUID: _authService.sub ?? "",
        dealerCode: _authService.getStoredDealerCode(),
      );
      await _localDatabaseService.delete(boxName, uid);

      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.delete.eventName,
        level: LogEventLevel.success,
        raw: jsonEncode({
          "uid": uid,
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.videoUpload,
        orderID: model.orderID,
        action: LogEventActionVideoUpload.delete.eventName,
        level: LogEventLevel.error,
        message: error.toString(),
        raw: jsonEncode({
          "uid": uid,
          "videoPath": model.cameraResult?.video.info.path ?? "",
          "pictures": model.cameraResult?.pictures.map((e) => e.path).toList() ?? [],
          "tagID": model.videoTagID,
          "typeId": model.videoTypeID,
          "description": model.videoDescription,
        }),
      );

      rethrow;
    }
  }

  @override
  Future<void> uploadVideo({
    required int orderID,
    required VideoUploadDTO videoUpload,
  }) async {
    final accountUID = _authService.accountUid ?? "";
    final token = (await _authService.token) ?? "";

    await _httpService.put(
      Uri.parse("$baseURL/api/v3/repair-order/$orderID/upload-media?account-uid=$accountUID"),
      data: videoUpload.toJson(),
      headers: {
        "x-authorization-truvideo": token,
      },
    );
  }

  @override
  Future<List<TCEUserModel>> getAdvisors() async {
    final accountUID = _authService.accountUid ?? "";
    final token = (await _authService.token) ?? "";

    final result = await _httpService.get(
      Uri.parse("$baseURL/api/v3/repair-order/getAdvisorsByAccountId?account-uid=$accountUID"),
      headers: {
        "x-authorization-truvideo": token,
      },
    );

    final items = (result.data! as List<dynamic>)
        .map((e) {
          try {
            return TCEUserModel.fromJson(e as Map<String, dynamic>);
          } catch (error) {
            log("Error parsing TCEUserModel", error: error);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();

    items.sort((a, b) => a.displayName.compareTo(b.displayName));
    return items;
  }

  @override
  Future<int> create({
    String jobServiceNumber = "",
    String orderType = "",
    int? advisorId,
    String firstName = "",
    String lastName = "",
    String mobileNumber = "",
    String email = "",
    String stockNo = "",
    String make = "",
    String model = "",
    String year = "",
    String color = "",
    bool isForReview = false,
  }) async {
    final data = {
      if (orderType == "REPAIR_ORDER") "jobServiceNumber": jobServiceNumber,
      if (orderType == "REPAIR_ORDER") "advisorId": advisorId,
      if (orderType == "REPAIR_ORDER") "isForReview": isForReview,
      "orderType": orderType,
      "customerDTO": {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "email": email,
      },
      if (orderType == "SALES_ORDER")
        "vehicleDTO": {
          "stockNo": stockNo,
          "make": make,
          "model": model,
          "year": year,
          "color": color,
        },
    };

    try {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.create.eventName,
        raw: jsonEncode(data),
        level: LogEventLevel.info,
      );

      final accountUID = _authService.accountUid ?? "";
      final token = (await _authService.token) ?? "";

      final result = await _httpService.post(
        Uri.parse("$baseURL/api/v3/repair-order/create"),
        params: {
          "account-uid": accountUID,
        },
        data: data,
        headers: {
          "x-authorization-truvideo": token,
        },
      );

      final orderID = (result.data! as Map<String, dynamic>)["id"];
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.create.eventName,
        raw: jsonEncode(data),
        orderID: orderID,
        level: LogEventLevel.success,
      );

      return orderID;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.create.eventName,
        raw: jsonEncode(data),
        message: error.toString(),
        level: LogEventLevel.error,
      );

      rethrow;
    }
  }

  @override
  Future<void> update({
    required int id,
    String orderType = "",
    String jobServiceNumber = "",
    int? advisorId,
    String firstName = "",
    String lastName = "",
    String mobileNumber = "",
    String email = "",
    String stockNo = "",
    String make = "",
    String model = "",
    String year = "",
    String color = "",
    bool isForReview = false,
  }) async {
    final data = {
      if (orderType == "REPAIR_ORDER") "jobServiceNumber": jobServiceNumber,
      if (orderType == "REPAIR_ORDER") "advisorId": advisorId,
      if (orderType == "REPAIR_ORDER") "isForReview": isForReview,
      "customerDTO": {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "email": email,
      },
      if (orderType == "SALES_ORDER")
        "vehicleDTO": {
          "stockNo": stockNo,
          "make": make,
          "model": model,
          "year": year,
          "color": color,
        },
    };

    try {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.update.eventName,
        raw: jsonEncode(data),
        orderID: id,
        level: LogEventLevel.info,
      );

      final accountUID = _authService.accountUid ?? "";
      final token = (await _authService.token) ?? "";

      await _httpService.put(
        Uri.parse("$baseURL/api/v3/repair-order/update/$id"),
        params: {
          "account-uid": accountUID,
        },
        data: data,
        headers: {
          "x-authorization-truvideo": token,
        },
      );

      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.update.eventName,
        raw: jsonEncode(data),
        orderID: id,
        level: LogEventLevel.success,
      );
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.update.eventName,
        raw: jsonEncode(data),
        orderID: id,
        level: LogEventLevel.error,
      );

      rethrow;
    }
  }

  @override
  Future<bool> validateJobServiceNumber(String jobServiceNumber) async {
    final token = (await _authService.token) ?? "";

    try {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.validateJobServiceNumber.eventName,
        raw: jsonEncode({"jobServiceNumber": jobServiceNumber}),
        level: LogEventLevel.info,
      );

      final response = await _httpService.post(
        Uri.parse("$baseURL/api/v3/repair-order/job-service-number/validate"),
        params: {
          "account-uid": _authService.accountUid ?? "",
        },
        data: {
          "jobServiceNumber": jobServiceNumber,
        },
        headers: {
          "x-authorization-truvideo": token,
        },
      );

      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.validateJobServiceNumber.eventName,
        raw: jsonEncode({"jobServiceNumber": jobServiceNumber}),
        level: LogEventLevel.success,
      );

      final r = response.data == true;
      return r;
    } catch (error) {
      _logEventService.logEvent(
        LogEventModule.orders,
        action: LogEventActionOrders.validateJobServiceNumber.eventName,
        raw: jsonEncode({"jobServiceNumber": jobServiceNumber}),
        message: error.toString(),
        level: LogEventLevel.error,
      );

      rethrow;
    }
  }
}
