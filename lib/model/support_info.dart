// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_info.freezed.dart';

part 'support_info.g.dart';

@freezed
class SupportInfoModel with _$SupportInfoModel {
  const SupportInfoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory SupportInfoModel({
    @Default("") String phoneId,
    @Default("") String phoneType,
    @Default("") String dealerName,
    @Default("") String dealerUuid,
    @Default("") String userId,
    @Default("") String appVersion,
    @Default("") String dateTime,
    @Default("") String phoneOS,
    @Default("") String wifiInternetSettings,
    @Default("") String truVideoServer,
    @Default("") String freeVirtualMemory,
    @Default("") String totalPhysicalMemory,
    @Default("") String freeDiskSpace,
    @Default('') String freeExternalStorage,
    @Default("") String videoStored,
    @Default("") String microphoneAccess,
    @Default("") String notificationAccess,
    @Default("") String networkType,
    @Default("") String recordingSettings,
    @Default("") String videoFormat,
    @Default("") String batteryLevel,
    @Default("") String bandwidthTest,
  }) = _SupportInfoModel;

  factory SupportInfoModel.fromJson(Map<String, dynamic> json) => _$SupportInfoModelFromJson(json);
}
