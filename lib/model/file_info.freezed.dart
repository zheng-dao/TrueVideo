// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'file_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileInfoModel _$FileInfoModelFromJson(Map<String, dynamic> json) {
  return _FileInfoModel.fromJson(json);
}

/// @nodoc
mixin _$FileInfoModel {
  String get filename => throw _privateConstructorUsedError;
  String? get fullPath => throw _privateConstructorUsedError;
  String? get originalFileName => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  String? get contentType => throw _privateConstructorUsedError;
  String? get fileId => throw _privateConstructorUsedError;
  bool? get isArchived => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileInfoModelCopyWith<FileInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileInfoModelCopyWith<$Res> {
  factory $FileInfoModelCopyWith(
          FileInfoModel value, $Res Function(FileInfoModel) then) =
      _$FileInfoModelCopyWithImpl<$Res>;
  $Res call(
      {String filename,
      String? fullPath,
      String? originalFileName,
      int? fileSize,
      String? contentType,
      String? fileId,
      bool? isArchived});
}

/// @nodoc
class _$FileInfoModelCopyWithImpl<$Res>
    implements $FileInfoModelCopyWith<$Res> {
  _$FileInfoModelCopyWithImpl(this._value, this._then);

  final FileInfoModel _value;
  // ignore: unused_field
  final $Res Function(FileInfoModel) _then;

  @override
  $Res call({
    Object? filename = freezed,
    Object? fullPath = freezed,
    Object? originalFileName = freezed,
    Object? fileSize = freezed,
    Object? contentType = freezed,
    Object? fileId = freezed,
    Object? isArchived = freezed,
  }) {
    return _then(_value.copyWith(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      fullPath: fullPath == freezed
          ? _value.fullPath
          : fullPath // ignore: cast_nullable_to_non_nullable
              as String?,
      originalFileName: originalFileName == freezed
          ? _value.originalFileName
          : originalFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: fileSize == freezed
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fileId: fileId == freezed
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String?,
      isArchived: isArchived == freezed
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_FileInfoModelCopyWith<$Res>
    implements $FileInfoModelCopyWith<$Res> {
  factory _$$_FileInfoModelCopyWith(
          _$_FileInfoModel value, $Res Function(_$_FileInfoModel) then) =
      __$$_FileInfoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String filename,
      String? fullPath,
      String? originalFileName,
      int? fileSize,
      String? contentType,
      String? fileId,
      bool? isArchived});
}

/// @nodoc
class __$$_FileInfoModelCopyWithImpl<$Res>
    extends _$FileInfoModelCopyWithImpl<$Res>
    implements _$$_FileInfoModelCopyWith<$Res> {
  __$$_FileInfoModelCopyWithImpl(
      _$_FileInfoModel _value, $Res Function(_$_FileInfoModel) _then)
      : super(_value, (v) => _then(v as _$_FileInfoModel));

  @override
  _$_FileInfoModel get _value => super._value as _$_FileInfoModel;

  @override
  $Res call({
    Object? filename = freezed,
    Object? fullPath = freezed,
    Object? originalFileName = freezed,
    Object? fileSize = freezed,
    Object? contentType = freezed,
    Object? fileId = freezed,
    Object? isArchived = freezed,
  }) {
    return _then(_$_FileInfoModel(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      fullPath: fullPath == freezed
          ? _value.fullPath
          : fullPath // ignore: cast_nullable_to_non_nullable
              as String?,
      originalFileName: originalFileName == freezed
          ? _value.originalFileName
          : originalFileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: fileSize == freezed
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fileId: fileId == freezed
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String?,
      isArchived: isArchived == freezed
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FileInfoModel extends _FileInfoModel {
  const _$_FileInfoModel(
      {required this.filename,
      this.fullPath,
      this.originalFileName,
      this.fileSize,
      this.contentType,
      this.fileId,
      this.isArchived})
      : super._();

  factory _$_FileInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_FileInfoModelFromJson(json);

  @override
  final String filename;
  @override
  final String? fullPath;
  @override
  final String? originalFileName;
  @override
  final int? fileSize;
  @override
  final String? contentType;
  @override
  final String? fileId;
  @override
  final bool? isArchived;

  @override
  String toString() {
    return 'FileInfoModel(filename: $filename, fullPath: $fullPath, originalFileName: $originalFileName, fileSize: $fileSize, contentType: $contentType, fileId: $fileId, isArchived: $isArchived)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileInfoModel &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality().equals(other.fullPath, fullPath) &&
            const DeepCollectionEquality()
                .equals(other.originalFileName, originalFileName) &&
            const DeepCollectionEquality().equals(other.fileSize, fileSize) &&
            const DeepCollectionEquality()
                .equals(other.contentType, contentType) &&
            const DeepCollectionEquality().equals(other.fileId, fileId) &&
            const DeepCollectionEquality()
                .equals(other.isArchived, isArchived));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(fullPath),
      const DeepCollectionEquality().hash(originalFileName),
      const DeepCollectionEquality().hash(fileSize),
      const DeepCollectionEquality().hash(contentType),
      const DeepCollectionEquality().hash(fileId),
      const DeepCollectionEquality().hash(isArchived));

  @JsonKey(ignore: true)
  @override
  _$$_FileInfoModelCopyWith<_$_FileInfoModel> get copyWith =>
      __$$_FileInfoModelCopyWithImpl<_$_FileInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileInfoModelToJson(this);
  }
}

abstract class _FileInfoModel extends FileInfoModel {
  const factory _FileInfoModel(
      {required final String filename,
      final String? fullPath,
      final String? originalFileName,
      final int? fileSize,
      final String? contentType,
      final String? fileId,
      final bool? isArchived}) = _$_FileInfoModel;
  const _FileInfoModel._() : super._();

  factory _FileInfoModel.fromJson(Map<String, dynamic> json) =
      _$_FileInfoModel.fromJson;

  @override
  String get filename => throw _privateConstructorUsedError;
  @override
  String? get fullPath => throw _privateConstructorUsedError;
  @override
  String? get originalFileName => throw _privateConstructorUsedError;
  @override
  int? get fileSize => throw _privateConstructorUsedError;
  @override
  String? get contentType => throw _privateConstructorUsedError;
  @override
  String? get fileId => throw _privateConstructorUsedError;
  @override
  bool? get isArchived => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FileInfoModelCopyWith<_$_FileInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
