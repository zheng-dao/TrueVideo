// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_enqueue_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OfflineEnqueueItemModel _$$_OfflineEnqueueItemModelFromJson(
        Map<String, dynamic> json) =>
    _$_OfflineEnqueueItemModel(
      uid: json['uid'] as String? ?? "",
      typeIndex: json['typeIndex'] as int? ?? 0,
      statusIndex: json['statusIndex'] as int? ?? 0,
      data: json['data'] as Map<String, dynamic>?,
      result: json['result'] as Map<String, dynamic>?,
      retryCount: json['retryCount'] as int? ?? 0,
      maxRetryCount: json['maxRetryCount'] as int? ?? 0,
      errorMessage: json['errorMessage'] as String? ?? "",
      createdAt: DateTimeConverter.fromJson(json['createdAt']),
      updatedAt: DateTimeConverter.fromJson(json['updatedAt']),
      startAt: DateTimeConverter.fromJson(json['startAt']),
      endAt: DateTimeConverter.fromJson(json['endAt']),
    );

Map<String, dynamic> _$$_OfflineEnqueueItemModelToJson(
        _$_OfflineEnqueueItemModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'typeIndex': instance.typeIndex,
      'statusIndex': instance.statusIndex,
      'data': instance.data,
      'result': instance.result,
      'retryCount': instance.retryCount,
      'maxRetryCount': instance.maxRetryCount,
      'errorMessage': instance.errorMessage,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'startAt': instance.startAt?.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
    };
