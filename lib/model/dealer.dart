// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dealer.freezed.dart';
part 'dealer.g.dart';

@freezed
class DealerModel with _$DealerModel {
  const DealerModel._();

  @JsonSerializable(explicitToJson: true)
  const factory DealerModel({
    @Default("") String name,
    @Default("") String phone,
  }) = _DealerModel;

  factory DealerModel.fromJson(Map<String, dynamic> json) => _$DealerModelFromJson(json);
}
