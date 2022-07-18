// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepairOrderDetailModel _$$_RepairOrderDetailModelFromJson(
        Map<String, dynamic> json) =>
    _$_RepairOrderDetailModel(
      id: json['id'] as int? ?? 0,
      createDate: DateTimeConverter.fromJson(json['createDate']),
      jobServiceNumber: json['jobServiceNumber'] as String? ?? "",
      dealer: json['dealer'] == null
          ? null
          : DealerModel.fromJson(json['dealer'] as Map<String, dynamic>),
      owner: json['owner'] == null
          ? null
          : TCEUserModel.fromJson(json['owner'] as Map<String, dynamic>),
      technician: json['technician'] == null
          ? null
          : TCEUserModel.fromJson(json['technician'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      orderStatus: json['orderStatus'] == null
          ? null
          : OrderStatusModel.fromJson(
              json['orderStatus'] as Map<String, dynamic>),
      vehicle: json['vehicle'] == null
          ? null
          : RepairOrderVehicleModel.fromJson(
              json['vehicle'] as Map<String, dynamic>),
      type: json['type'] as String? ?? "",
      isForReview: json['isForReview'] as bool? ?? false,
    );

Map<String, dynamic> _$$_RepairOrderDetailModelToJson(
        _$_RepairOrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createDate': instance.createDate?.toIso8601String(),
      'jobServiceNumber': instance.jobServiceNumber,
      'dealer': instance.dealer?.toJson(),
      'owner': instance.owner?.toJson(),
      'technician': instance.technician?.toJson(),
      'customer': instance.customer?.toJson(),
      'orderStatus': instance.orderStatus?.toJson(),
      'vehicle': instance.vehicle?.toJson(),
      'type': instance.type,
      'isForReview': instance.isForReview,
    };
