// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Section _$$_SectionFromJson(Map<String, dynamic> json) => _$_Section(
      uid: json['uid'] as String,
      config: (json['config'] as List<dynamic>?)
              ?.map((e) => SectionConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SectionConfig>[],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Item>[],
    );

Map<String, dynamic> _$$_SectionToJson(_$_Section instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'config': instance.config,
      'items': instance.items,
    };
