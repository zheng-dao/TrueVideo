// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dealer.freezed.dart';

part 'user_dealer.g.dart';

@freezed
class UserDealerModel with _$UserDealerModel {
  const UserDealerModel._();

  @JsonSerializable(explicitToJson: true)
  const factory UserDealerModel({
    @Default("") String dealerCodeType,
    @Default("") String publicDealerUuid,
    @Default("") String name
  }) = _UserDealerModel;

  factory UserDealerModel.fromJson(Map<String, dynamic> json) => _$UserDealerModelFromJson(json);
}
