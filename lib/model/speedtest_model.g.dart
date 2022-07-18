// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speedtest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SpeedtestModel _$$_SpeedtestModelFromJson(Map<String, dynamic> json) =>
    _$_SpeedtestModel(
      transferRate: (json['transferRate'] as num?)?.toDouble() ?? 0,
      speedUnit: json['speedUnit'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$_SpeedtestModelToJson(_$_SpeedtestModel instance) =>
    <String, dynamic>{
      'transferRate': instance.transferRate,
      'speedUnit': instance.speedUnit,
      'type': instance.type,
    };
