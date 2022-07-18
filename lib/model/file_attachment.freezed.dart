// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'file_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileAttachmentModel _$FileAttachmentModelFromJson(Map<String, dynamic> json) {
  return _FileAttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$FileAttachmentModel {
  String? get url => throw _privateConstructorUsedError;
  String? get contentType => throw _privateConstructorUsedError;
  String? get s3FileKey => throw _privateConstructorUsedError;
  TextMessageModel? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileAttachmentModelCopyWith<FileAttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileAttachmentModelCopyWith<$Res> {
  factory $FileAttachmentModelCopyWith(
          FileAttachmentModel value, $Res Function(FileAttachmentModel) then) =
      _$FileAttachmentModelCopyWithImpl<$Res>;
  $Res call(
      {String? url,
      String? contentType,
      String? s3FileKey,
      TextMessageModel? message});

  $TextMessageModelCopyWith<$Res>? get message;
}

/// @nodoc
class _$FileAttachmentModelCopyWithImpl<$Res>
    implements $FileAttachmentModelCopyWith<$Res> {
  _$FileAttachmentModelCopyWithImpl(this._value, this._then);

  final FileAttachmentModel _value;
  // ignore: unused_field
  final $Res Function(FileAttachmentModel) _then;

  @override
  $Res call({
    Object? url = freezed,
    Object? contentType = freezed,
    Object? s3FileKey = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      s3FileKey: s3FileKey == freezed
          ? _value.s3FileKey
          : s3FileKey // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TextMessageModel?,
    ));
  }

  @override
  $TextMessageModelCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $TextMessageModelCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
abstract class _$$_FileAttachmentModelCopyWith<$Res>
    implements $FileAttachmentModelCopyWith<$Res> {
  factory _$$_FileAttachmentModelCopyWith(_$_FileAttachmentModel value,
          $Res Function(_$_FileAttachmentModel) then) =
      __$$_FileAttachmentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? url,
      String? contentType,
      String? s3FileKey,
      TextMessageModel? message});

  @override
  $TextMessageModelCopyWith<$Res>? get message;
}

/// @nodoc
class __$$_FileAttachmentModelCopyWithImpl<$Res>
    extends _$FileAttachmentModelCopyWithImpl<$Res>
    implements _$$_FileAttachmentModelCopyWith<$Res> {
  __$$_FileAttachmentModelCopyWithImpl(_$_FileAttachmentModel _value,
      $Res Function(_$_FileAttachmentModel) _then)
      : super(_value, (v) => _then(v as _$_FileAttachmentModel));

  @override
  _$_FileAttachmentModel get _value => super._value as _$_FileAttachmentModel;

  @override
  $Res call({
    Object? url = freezed,
    Object? contentType = freezed,
    Object? s3FileKey = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_FileAttachmentModel(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String?,
      s3FileKey: s3FileKey == freezed
          ? _value.s3FileKey
          : s3FileKey // ignore: cast_nullable_to_non_nullable
              as String?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as TextMessageModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_FileAttachmentModel extends _FileAttachmentModel {
  const _$_FileAttachmentModel(
      {this.url, this.contentType, this.s3FileKey, this.message})
      : super._();

  factory _$_FileAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$$_FileAttachmentModelFromJson(json);

  @override
  final String? url;
  @override
  final String? contentType;
  @override
  final String? s3FileKey;
  @override
  final TextMessageModel? message;

  @override
  String toString() {
    return 'FileAttachmentModel(url: $url, contentType: $contentType, s3FileKey: $s3FileKey, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileAttachmentModel &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.contentType, contentType) &&
            const DeepCollectionEquality().equals(other.s3FileKey, s3FileKey) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(contentType),
      const DeepCollectionEquality().hash(s3FileKey),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_FileAttachmentModelCopyWith<_$_FileAttachmentModel> get copyWith =>
      __$$_FileAttachmentModelCopyWithImpl<_$_FileAttachmentModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileAttachmentModelToJson(this);
  }
}

abstract class _FileAttachmentModel extends FileAttachmentModel {
  const factory _FileAttachmentModel(
      {final String? url,
      final String? contentType,
      final String? s3FileKey,
      final TextMessageModel? message}) = _$_FileAttachmentModel;
  const _FileAttachmentModel._() : super._();

  factory _FileAttachmentModel.fromJson(Map<String, dynamic> json) =
      _$_FileAttachmentModel.fromJson;

  @override
  String? get url => throw _privateConstructorUsedError;
  @override
  String? get contentType => throw _privateConstructorUsedError;
  @override
  String? get s3FileKey => throw _privateConstructorUsedError;
  @override
  TextMessageModel? get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_FileAttachmentModelCopyWith<_$_FileAttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
