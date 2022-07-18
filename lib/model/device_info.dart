// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';

part 'device_info.g.dart';

@freezed
class DeviceInfoModel with _$DeviceInfoModel {
  const DeviceInfoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory DeviceInfoModel({
    @Default("") String id,
    @Default("") String manufacturer,
    @Default("") String model,
    @Default("") String name,
    @Default("") String phoneOS,
  }) = _DeviceInfoModel;

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) => _$DeviceInfoModelFromJson(json);
}
