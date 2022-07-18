// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_upload_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoUploadVideoDTO _$VideoUploadVideoDTOFromJson(Map<String, dynamic> json) {
  return _VideoUploadVideoDTO.fromJson(json);
}

/// @nodoc
mixin _$VideoUploadVideoDTO {
  String get thumbnail => throw _privateConstructorUsedError;
  String get videoLink => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;
  String get videoTag => throw _privateConstructorUsedError;
  String get videoType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoUploadVideoDTOCopyWith<VideoUploadVideoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoUploadVideoDTOCopyWith<$Res> {
  factory $VideoUploadVideoDTOCopyWith(
          VideoUploadVideoDTO value, $Res Function(VideoUploadVideoDTO) then) =
      _$VideoUploadVideoDTOCopyWithImpl<$Res>;
  $Res call(
      {String thumbnail,
      String videoLink,
      int length,
      String videoTag,
      String videoType,
      String description});
}

/// @nodoc
class _$VideoUploadVideoDTOCopyWithImpl<$Res>
    implements $VideoUploadVideoDTOCopyWith<$Res> {
  _$VideoUploadVideoDTOCopyWithImpl(this._value, this._then);

  final VideoUploadVideoDTO _value;
  // ignore: unused_field
  final $Res Function(VideoUploadVideoDTO) _then;

  @override
  $Res call({
    Object? thumbnail = freezed,
    Object? videoLink = freezed,
    Object? length = freezed,
    Object? videoTag = freezed,
    Object? videoType = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      videoLink: videoLink == freezed
          ? _value.videoLink
          : videoLink // ignore: cast_nullable_to_non_nullable
              as String,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      videoTag: videoTag == freezed
          ? _value.videoTag
          : videoTag // ignore: cast_nullable_to_non_nullable
              as String,
      videoType: videoType == freezed
          ? _value.videoType
          : videoType // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoUploadVideoDTOCopyWith<$Res>
    implements $VideoUploadVideoDTOCopyWith<$Res> {
  factory _$$_VideoUploadVideoDTOCopyWith(_$_VideoUploadVideoDTO value,
          $Res Function(_$_VideoUploadVideoDTO) then) =
      __$$_VideoUploadVideoDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {String thumbnail,
      String videoLink,
      int length,
      String videoTag,
      String videoType,
      String description});
}

/// @nodoc
class __$$_VideoUploadVideoDTOCopyWithImpl<$Res>
    extends _$VideoUploadVideoDTOCopyWithImpl<$Res>
    implements _$$_VideoUploadVideoDTOCopyWith<$Res> {
  __$$_VideoUploadVideoDTOCopyWithImpl(_$_VideoUploadVideoDTO _value,
      $Res Function(_$_VideoUploadVideoDTO) _then)
      : super(_value, (v) => _then(v as _$_VideoUploadVideoDTO));

  @override
  _$_VideoUploadVideoDTO get _value => super._value as _$_VideoUploadVideoDTO;

  @override
  $Res call({
    Object? thumbnail = freezed,
    Object? videoLink = freezed,
    Object? length = freezed,
    Object? videoTag = freezed,
    Object? videoType = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_VideoUploadVideoDTO(
      thumbnail: thumbnail == freezed
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      videoLink: videoLink == freezed
          ? _value.videoLink
          : videoLink // ignore: cast_nullable_to_non_nullable
              as String,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      videoTag: videoTag == freezed
          ? _value.videoTag
          : videoTag // ignore: cast_nullable_to_non_nullable
              as String,
      videoType: videoType == freezed
          ? _value.videoType
          : videoType // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoUploadVideoDTO extends _VideoUploadVideoDTO {
  const _$_VideoUploadVideoDTO(
      {this.thumbnail = "",
      this.videoLink = "",
      this.length = 0,
      this.videoTag = "",
      this.videoType = "",
      this.description = ""})
      : super._();

  factory _$_VideoUploadVideoDTO.fromJson(Map<String, dynamic> json) =>
      _$$_VideoUploadVideoDTOFromJson(json);

  @override
  @JsonKey()
  final String thumbnail;
  @override
  @JsonKey()
  final String videoLink;
  @override
  @JsonKey()
  final int length;
  @override
  @JsonKey()
  final String videoTag;
  @override
  @JsonKey()
  final String videoType;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'VideoUploadVideoDTO(thumbnail: $thumbnail, videoLink: $videoLink, length: $length, videoTag: $videoTag, videoType: $videoType, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoUploadVideoDTO &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail) &&
            const DeepCollectionEquality().equals(other.videoLink, videoLink) &&
            const DeepCollectionEquality().equals(other.length, length) &&
            const DeepCollectionEquality().equals(other.videoTag, videoTag) &&
            const DeepCollectionEquality().equals(other.videoType, videoType) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(thumbnail),
      const DeepCollectionEquality().hash(videoLink),
      const DeepCollectionEquality().hash(length),
      const DeepCollectionEquality().hash(videoTag),
      const DeepCollectionEquality().hash(videoType),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$_VideoUploadVideoDTOCopyWith<_$_VideoUploadVideoDTO> get copyWith =>
      __$$_VideoUploadVideoDTOCopyWithImpl<_$_VideoUploadVideoDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoUploadVideoDTOToJson(this);
  }
}

abstract class _VideoUploadVideoDTO extends VideoUploadVideoDTO {
  const factory _VideoUploadVideoDTO(
      {final String thumbnail,
      final String videoLink,
      final int length,
      final String videoTag,
      final String videoType,
      final String description}) = _$_VideoUploadVideoDTO;
  const _VideoUploadVideoDTO._() : super._();

  factory _VideoUploadVideoDTO.fromJson(Map<String, dynamic> json) =
      _$_VideoUploadVideoDTO.fromJson;

  @override
  String get thumbnail => throw _privateConstructorUsedError;
  @override
  String get videoLink => throw _privateConstructorUsedError;
  @override
  int get length => throw _privateConstructorUsedError;
  @override
  String get videoTag => throw _privateConstructorUsedError;
  @override
  String get videoType => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoUploadVideoDTOCopyWith<_$_VideoUploadVideoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
