// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExtraNote _$$_ExtraNoteFromJson(Map<String, dynamic> json) => _$_ExtraNote(
      uid: json['uid'] as String,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      text: json['text'] as String? ?? "",
      style: json['style'] as String? ?? "",
      config: (json['config'] as List<dynamic>?)
              ?.map((e) => ExtraNoteConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExtraNoteConfig>[],
    );

Map<String, dynamic> _$$_ExtraNoteToJson(_$_ExtraNote instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'text': instance.text,
      'style': instance.style,
      'config': instance.config.map((e) => e.toJson()).toList(),
    };
