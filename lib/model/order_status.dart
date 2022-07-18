// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_status.freezed.dart';
part 'order_status.g.dart';

@freezed
class OrderStatusModel with _$OrderStatusModel {
  const OrderStatusModel._();

  @JsonSerializable(explicitToJson: true)
  const factory OrderStatusModel({
    @Default("") String key,
    @Default("") String value,
  }) = _OrderStatusModel;

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => _$OrderStatusModelFromJson(json);
}
