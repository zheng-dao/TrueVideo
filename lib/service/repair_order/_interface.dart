import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/pagination.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/model/ro/upload_video_request.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/service/repair_order/dto/video_upload.dart';

enum RepairOrderTypeFilter {
  all,
  repairOrders,
  salesOrders,
}

abstract class RepairOrderService {
  Future<PaginationModel<RepairOrderModel>> getList({
    int page = 0,
    int pageSize = 20,
    int? id,
    RepairOrderTypeFilter type = RepairOrderTypeFilter.all,
    String filterBy = "",
    String query = "",
  });

  Future<List<RepairOrderModel>> getCachedList({String status = ""});

  Future<void> setCacheList({String status = "", required List<RepairOrderModel> items,});

  Future<void> updateCacheList(RepairOrderModel item);

  Future<RepairOrderDetailModel?> getCachedDetail(int id);

  Future<RepairOrderDetailModel?> getDetail(int id);

  Future<RepairOrderUploadVideoRequestModel> addVideoUploadRequest({
    required int orderID,
    required String orderType,
    required CameraResultModel cameraResult,
    String tagId = "",
    String typeId = "",
    String description = "",

  });

  Future<RepairOrderUploadVideoRequestModel?> getVideoUploadRequestByUID(String uid);

  Future<RepairOrderUploadVideoRequestModel?> updateVideoUploadRequest(RepairOrderUploadVideoRequestModel model);

  Future<List<RepairOrderUploadVideoRequestModel>> getVideoUploadRequests({required int orderID});

  Stream<List<RepairOrderUploadVideoRequestModel>> streamVideoUploadRequests({required int orderID});

  Stream<RepairOrderUploadVideoRequestModel?> streamVideoUploadRequestByUID(String uid);

  Future<void> deleteVideoUploadRequest(String uid);

  Future<void> startVideoUploadRequest(String uid);

  Future<void> retryVideoUploadRequest(String uid);

  Future<void> uploadVideo({
    required int orderID,
    required VideoUploadDTO videoUpload,
  });

  Future<List<TCEUserModel>> getAdvisors();

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
  });

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
  });

  Future<bool> validateJobServiceNumber(String jobServiceNumber);
}
