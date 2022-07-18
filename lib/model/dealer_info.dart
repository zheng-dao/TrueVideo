// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dealer_info.freezed.dart';

part 'dealer_info.g.dart';

@freezed
class DealerInfoModel with _$DealerInfoModel {
  const DealerInfoModel._();

  @JsonSerializable(explicitToJson: true)
  const factory DealerInfoModel({
    @Default("") String publicDealerUuid,
    @Default("") String dealerCodeType,
    @Default("") String name,
  }) = _DealerInfoModel;

  factory DealerInfoModel.fromJson(Map<String, dynamic> json) => _$DealerInfoModelFromJson(json);
}
