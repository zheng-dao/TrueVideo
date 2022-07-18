// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_order_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RepairOrderVehicleModel _$$_RepairOrderVehicleModelFromJson(
        Map<String, dynamic> json) =>
    _$_RepairOrderVehicleModel(
      id: json['id'] as int? ?? 0,
      jobServiceNumber: json['jobServiceNumber'] as String? ?? "",
      createDate: DateTimeConverter.fromJson(json['createDate']),
      updateDate: DateTimeConverter.fromJson(json['updateDate']),
      stockNo: json['stockNo'] as String? ?? "",
      make: json['make'] as String? ?? "",
      model: json['model'] as String? ?? "",
      year: json['year'] as String? ?? "",
      color: json['color'] as String? ?? "",
    );

Map<String, dynamic> _$$_RepairOrderVehicleModelToJson(
        _$_RepairOrderVehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobServiceNumber': instance.jobServiceNumber,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'stockNo': instance.stockNo,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'color': instance.color,
    };
