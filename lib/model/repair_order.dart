// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/customer.dart';
import 'package:truvideo_enterprise/model/order_status.dart';

import 'converter/date.dart';

part 'repair_order.freezed.dart';

part 'repair_order.g.dart';

@freezed
class RepairOrderModel with _$RepairOrderModel {
  const RepairOrderModel._();

  @JsonSerializable(explicitToJson: true)
  const factory RepairOrderModel({
    @Default(0) int id,
    @Default("") String jobServiceNumber,
    @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson) DateTime? createDate,
    CustomerModel? customer,
    OrderStatusModel? orderStatus,
  }) = _RepairOrderModel;

  factory RepairOrderModel.fromJson(Map<String, dynamic> json) => _$RepairOrderModelFromJson(json);
}
