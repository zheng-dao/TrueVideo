import 'package:freezed_annotation/freezed_annotation.dart';

part 'speedtest_model.freezed.dart';
part 'speedtest_model.g.dart';

@freezed
class SpeedtestModel with _$SpeedtestModel {
  const SpeedtestModel._();
  factory SpeedtestModel({
    @Default(0) double transferRate,
    @Default('') String speedUnit,
    @Default('') String type,
  }) = _SpeedtestModel;

  factory SpeedtestModel.fromJson(Map<String, dynamic> json) => _$SpeedtestModelFromJson(json);
  String get speedLabel => "${transferRate.toStringAsFixed(2)} $speedUnit";
}
