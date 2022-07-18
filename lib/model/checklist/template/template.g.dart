// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Template _$$_TemplateFromJson(Map<String, dynamic> json) => _$_Template(
      uid: json['uid'] as String,
      accountUID: json['accountUID'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
      templateName: json['templateName'] as String? ?? "",
      description: json['description'] as String? ?? "",
      category: json['category'] as String? ?? "",
      subCategory: json['subCategory'] as String? ?? "",
      version: json['version'] as String? ?? "",
      templateStatus: json['templateStatus'] as String? ?? "",
      definitions: json['definitions'] == null
          ? null
          : Definitions.fromJson(json['definitions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TemplateToJson(_$_Template instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'accountUID': instance.accountUID,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'templateName': instance.templateName,
      'description': instance.description,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'version': instance.version,
      'templateStatus': instance.templateStatus,
      'definitions': instance.definitions,
    };
