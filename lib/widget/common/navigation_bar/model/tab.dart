// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab.freezed.dart';

part 'tab.g.dart';

@freezed
class TabModel with _$TabModel {
  const TabModel._();

  @JsonSerializable(explicitToJson: true)
  const factory TabModel({
    @Default(0) int value,
    @Default("") String text,
    @Default(0) int icon,
  }) = _TabModel;

  factory TabModel.fromJson(Map<String, dynamic> json) => _$TabModelFromJson(json);
}
