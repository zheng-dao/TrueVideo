// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileInfoModel _$$_FileInfoModelFromJson(Map<String, dynamic> json) =>
    _$_FileInfoModel(
      filename: json['filename'] as String,
      fullPath: json['fullPath'] as String?,
      originalFileName: json['originalFileName'] as String?,
      fileSize: json['fileSize'] as int?,
      contentType: json['contentType'] as String?,
      fileId: json['fileId'] as String?,
      isArchived: json['isArchived'] as bool?,
    );

Map<String, dynamic> _$$_FileInfoModelToJson(_$_FileInfoModel instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'fullPath': instance.fullPath,
      'originalFileName': instance.originalFileName,
      'fileSize': instance.fileSize,
      'contentType': instance.contentType,
      'fileId': instance.fileId,
      'isArchived': instance.isArchived,
    };
