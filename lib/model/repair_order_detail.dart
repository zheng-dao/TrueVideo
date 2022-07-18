// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/customer.dart';
import 'package:truvideo_enterprise/model/dealer.dart';
import 'package:truvideo_enterprise/model/order_status.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';

import 'converter/date.dart';
import 'repair_order_vehicle.dart';

part 'repair_order_detail.freezed.dart';

part 'repair_order_detail.g.dart';

@freezed
class RepairOrderDetailModel with _$RepairOrderDetailModel {
  const RepairOrderDetailModel._();

  @JsonSerializable(explicitToJson: true)
  const factory RepairOrderDetailModel({
    @Default(0) int id,
    @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson) DateTime? createDate,
    @Default("") String jobServiceNumber,
    DealerModel? dealer,
    TCEUserModel? owner,
    TCEUserModel? technician,
    CustomerModel? customer,
    OrderStatusModel? orderStatus,
    RepairOrderVehicleModel? vehicle,
    @Default("") String type,
    @Default(false) bool isForReview,
  }) = _RepairOrderDetailModel;

  factory RepairOrderDetailModel.fromJson(Map<String, dynamic> json) => _$RepairOrderDetailModelFromJson(json);

  bool get isSalesOrder {
    return type == "SALES_ORDER";
  }

  bool get isRepairOrder {
    return type == "REPAIR_ORDER";
  }
}
