// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DealerInfoModel _$$_DealerInfoModelFromJson(Map<String, dynamic> json) =>
    _$_DealerInfoModel(
      publicDealerUuid: json['publicDealerUuid'] as String? ?? "",
      dealerCodeType: json['dealerCodeType'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$$_DealerInfoModelToJson(_$_DealerInfoModel instance) =>
    <String, dynamic>{
      'publicDealerUuid': instance.publicDealerUuid,
      'dealerCodeType': instance.dealerCodeType,
      'name': instance.name,
    };
