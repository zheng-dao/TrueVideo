// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/converter/date.dart';

import 'offline_enqueue_item_status.dart';
import 'offline_enqueue_item_type.dart';

part 'offline_enqueue_item.freezed.dart';

part 'offline_enqueue_item.g.dart';

@freezed
class OfflineEnqueueItemModel with _$OfflineEnqueueItemModel {
  const OfflineEnqueueItemModel._();

  @JsonSerializable(explicitToJson: true)
  const factory OfflineEnqueueItemModel({
    @Default("") String uid,
    @Default(0) int typeIndex,
    @Default(0) int statusIndex,
    Map<String, dynamic>? data,
    Map<String, dynamic>? result,
    @Default(0) int retryCount,
    @Default(0) int maxRetryCount,
    @Default("") String errorMessage,
    @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
    @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
    @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? startAt,
    @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? endAt,
  }) = _OfflineEnqueueItemModel;

  factory OfflineEnqueueItemModel.fromJson(Map<String, dynamic> json) => _$OfflineEnqueueItemModelFromJson(json);

  OfflineEnqueueItemType get type {
    try {
      return OfflineEnqueueItemType.values[typeIndex];
    } catch (_) {
      return OfflineEnqueueItemType.unknown;
    }
  }


  OfflineEnqueueItemStatus get status{
    try {
      return OfflineEnqueueItemStatus.values[statusIndex];
    } catch (_) {
      return OfflineEnqueueItemStatus.pending;
    }
  }

}
