// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_code_access_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DealerCodeAccessHistoryModel _$$_DealerCodeAccessHistoryModelFromJson(
        Map<String, dynamic> json) =>
    _$_DealerCodeAccessHistoryModel(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      dealerCode: json['dealerCode'] as String? ?? "",
    );

Map<String, dynamic> _$$_DealerCodeAccessHistoryModelToJson(
        _$_DealerCodeAccessHistoryModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'dealerCode': instance.dealerCode,
    };
