// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/customer.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/model/text_message.dart';

part 'repair_order_conversation.freezed.dart';

part 'repair_order_conversation.g.dart';

@freezed
class RepairOrderConversationModel with _$RepairOrderConversationModel {
  const RepairOrderConversationModel._();

  @JsonSerializable(explicitToJson: true)
  const factory RepairOrderConversationModel({
    List<TextMessageModel>? messages,
    TextMessageModel? lastTextMessage,
    CustomerModel? customer,
    String? status,
    TCEUserModel? owner,
  }) = _RepairOrderConversationModel;

  factory RepairOrderConversationModel.fromJson(Map<String, dynamic> json) => _$RepairOrderConversationModelFromJson(json);
}
