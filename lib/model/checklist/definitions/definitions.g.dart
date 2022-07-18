// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definitions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Definitions _$$_DefinitionsFromJson(Map<String, dynamic> json) =>
    _$_Definitions(
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Section>[],
    );

Map<String, dynamic> _$$_DefinitionsToJson(_$_Definitions instance) =>
    <String, dynamic>{
      'sections': instance.sections,
    };
