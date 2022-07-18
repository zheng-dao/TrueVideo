// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'converter/date.dart';

part 'repair_order_vehicle.freezed.dart';

part 'repair_order_vehicle.g.dart';

@freezed
class RepairOrderVehicleModel with _$RepairOrderVehicleModel {
  const RepairOrderVehicleModel._();

  @JsonSerializable(explicitToJson: true)
  const factory RepairOrderVehicleModel({
    @Default(0) int id,
    @Default("") String jobServiceNumber,
    @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson) DateTime? createDate,
    @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson) DateTime? updateDate,
    @Default("") String stockNo,
    @Default("") String make,
    @Default("") String model,
    @Default("") String year,
    @Default("") String color,
  }) = _RepairOrderVehicleModel;

  factory RepairOrderVehicleModel.fromJson(Map<String, dynamic> json) => _$RepairOrderVehicleModelFromJson(json);

  String get displayName {
    final rest = [year, color, make, model].where((e) => e.trim().isNotEmpty).join(" ");
    return [stockNo, rest].where((e) => e.trim().isNotEmpty).join(", ");
  }
}
