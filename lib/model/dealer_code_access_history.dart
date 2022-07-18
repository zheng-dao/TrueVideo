// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dealer_code_access_history.freezed.dart';

part 'dealer_code_access_history.g.dart';

@freezed
class DealerCodeAccessHistoryModel with _$DealerCodeAccessHistoryModel {
  const DealerCodeAccessHistoryModel._();

  @JsonSerializable(explicitToJson: true)
  const factory DealerCodeAccessHistoryModel({
    DateTime? date,
    @Default("") String dealerCode,
  }) = _DealerCodeAccessHistoryModel;

  factory DealerCodeAccessHistoryModel.fromJson(Map<String, dynamic> json) => _$DealerCodeAccessHistoryModelFromJson(json);
}
