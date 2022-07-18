// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_upload_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoUploadImageDTO _$VideoUploadImageDTOFromJson(Map<String, dynamic> json) {
  return _VideoUploadImageDTO.fromJson(json);
}

/// @nodoc
mixin _$VideoUploadImageDTO {
  String get name => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoUploadImageDTOCopyWith<VideoUploadImageDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoUploadImageDTOCopyWith<$Res> {
  factory $VideoUploadImageDTOCopyWith(
          VideoUploadImageDTO value, $Res Function(VideoUploadImageDTO) then) =
      _$VideoUploadImageDTOCopyWithImpl<$Res>;
  $Res call(
      {String name, String fileId, String contentType, String url, int size});
}

/// @nodoc
class _$VideoUploadImageDTOCopyWithImpl<$Res>
    implements $VideoUploadImageDTOCopyWith<$Res> {
  _$VideoUploadImageDTOCopyWithImpl(this._value, this._then);

  final VideoUploadImageDTO _value;
  // ignore: unused_field
  final $Res Function(VideoUploadImageDTO) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? fileId = freezed,
    Object? contentType = freezed,
    Object? url = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: fileId == freezed
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoUploadImageDTOCopyWith<$Res>
    implements $VideoUploadImageDTOCopyWith<$Res> {
  factory _$$_VideoUploadImageDTOCopyWith(_$_VideoUploadImageDTO value,
          $Res Function(_$_VideoUploadImageDTO) then) =
      __$$_VideoUploadImageDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, String fileId, String contentType, String url, int size});
}

/// @nodoc
class __$$_VideoUploadImageDTOCopyWithImpl<$Res>
    extends _$VideoUploadImageDTOCopyWithImpl<$Res>
    implements _$$_VideoUploadImageDTOCopyWith<$Res> {
  __$$_VideoUploadImageDTOCopyWithImpl(_$_VideoUploadImageDTO _value,
      $Res Function(_$_VideoUploadImageDTO) _then)
      : super(_value, (v) => _then(v as _$_VideoUploadImageDTO));

  @override
  _$_VideoUploadImageDTO get _value => super._value as _$_VideoUploadImageDTO;

  @override
  $Res call({
    Object? name = freezed,
    Object? fileId = freezed,
    Object? contentType = freezed,
    Object? url = freezed,
    Object? size = freezed,
  }) {
    return _then(_$_VideoUploadImageDTO(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: fileId == freezed
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: contentType == freezed
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoUploadImageDTO extends _VideoUploadImageDTO {
  const _$_VideoUploadImageDTO(
      {this.name = "",
      this.fileId = "",
      this.contentType = "",
      this.url = "",
      this.size = 0})
      : super._();

  factory _$_VideoUploadImageDTO.fromJson(Map<String, dynamic> json) =>
      _$$_VideoUploadImageDTOFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String fileId;
  @override
  @JsonKey()
  final String contentType;
  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final int size;

  @override
  String toString() {
    return 'VideoUploadImageDTO(name: $name, fileId: $fileId, contentType: $contentType, url: $url, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoUploadImageDTO &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.fileId, fileId) &&
            const DeepCollectionEquality()
                .equals(other.contentType, contentType) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.size, size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(fileId),
      const DeepCollectionEquality().hash(contentType),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(size));

  @JsonKey(ignore: true)
  @override
  _$$_VideoUploadImageDTOCopyWith<_$_VideoUploadImageDTO> get copyWith =>
      __$$_VideoUploadImageDTOCopyWithImpl<_$_VideoUploadImageDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoUploadImageDTOToJson(this);
  }
}

abstract class _VideoUploadImageDTO extends VideoUploadImageDTO {
  const factory _VideoUploadImageDTO(
      {final String name,
      final String fileId,
      final String contentType,
      final String url,
      final int size}) = _$_VideoUploadImageDTO;
  const _VideoUploadImageDTO._() : super._();

  factory _VideoUploadImageDTO.fromJson(Map<String, dynamic> json) =
      _$_VideoUploadImageDTO.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get fileId => throw _privateConstructorUsedError;
  @override
  String get contentType => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  int get size => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoUploadImageDTOCopyWith<_$_VideoUploadImageDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
