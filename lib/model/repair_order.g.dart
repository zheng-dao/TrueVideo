// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepairOrderModel _$$_RepairOrderModelFromJson(Map<String, dynamic> json) =>
    _$_RepairOrderModel(
      id: json['id'] as int? ?? 0,
      jobServiceNumber: json['jobServiceNumber'] as String? ?? "",
      createDate: DateTimeConverter.fromJson(json['createDate']),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      orderStatus: json['orderStatus'] == null
          ? null
          : OrderStatusModel.fromJson(
              json['orderStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RepairOrderModelToJson(_$_RepairOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobServiceNumber': instance.jobServiceNumber,
      'createDate': instance.createDate?.toIso8601String(),
      'customer': instance.customer?.toJson(),
      'orderStatus': instance.orderStatus?.toJson(),
    };
