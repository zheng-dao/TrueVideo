// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dealer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserDealerModel _$$_UserDealerModelFromJson(Map<String, dynamic> json) =>
    _$_UserDealerModel(
      dealerCodeType: json['dealerCodeType'] as String? ?? "",
      publicDealerUuid: json['publicDealerUuid'] as String? ?? "",
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$$_UserDealerModelToJson(_$_UserDealerModel instance) =>
    <String, dynamic>{
      'dealerCodeType': instance.dealerCodeType,
      'publicDealerUuid': instance.publicDealerUuid,
      'name': instance.name,
    };
