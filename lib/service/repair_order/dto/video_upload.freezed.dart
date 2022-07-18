// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoUploadDTO _$VideoUploadDTOFromJson(Map<String, dynamic> json) {
  return _VideoUploadDTO.fromJson(json);
}

/// @nodoc
mixin _$VideoUploadDTO {
  VideoUploadVideoDTO? get videoDTO => throw _privateConstructorUsedError;
  List<VideoUploadImageDTO> get imageDTO => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoUploadDTOCopyWith<VideoUploadDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoUploadDTOCopyWith<$Res> {
  factory $VideoUploadDTOCopyWith(
          VideoUploadDTO value, $Res Function(VideoUploadDTO) then) =
      _$VideoUploadDTOCopyWithImpl<$Res>;
  $Res call(
      {VideoUploadVideoDTO? videoDTO, List<VideoUploadImageDTO> imageDTO});

  $VideoUploadVideoDTOCopyWith<$Res>? get videoDTO;
}

/// @nodoc
class _$VideoUploadDTOCopyWithImpl<$Res>
    implements $VideoUploadDTOCopyWith<$Res> {
  _$VideoUploadDTOCopyWithImpl(this._value, this._then);

  final VideoUploadDTO _value;
  // ignore: unused_field
  final $Res Function(VideoUploadDTO) _then;

  @override
  $Res call({
    Object? videoDTO = freezed,
    Object? imageDTO = freezed,
  }) {
    return _then(_value.copyWith(
      videoDTO: videoDTO == freezed
          ? _value.videoDTO
          : videoDTO // ignore: cast_nullable_to_non_nullable
              as VideoUploadVideoDTO?,
      imageDTO: imageDTO == freezed
          ? _value.imageDTO
          : imageDTO // ignore: cast_nullable_to_non_nullable
              as List<VideoUploadImageDTO>,
    ));
  }

  @override
  $VideoUploadVideoDTOCopyWith<$Res>? get videoDTO {
    if (_value.videoDTO == null) {
      return null;
    }

    return $VideoUploadVideoDTOCopyWith<$Res>(_value.videoDTO!, (value) {
      return _then(_value.copyWith(videoDTO: value));
    });
  }
}

/// @nodoc
abstract class _$$_VideoUploadDTOCopyWith<$Res>
    implements $VideoUploadDTOCopyWith<$Res> {
  factory _$$_VideoUploadDTOCopyWith(
          _$_VideoUploadDTO value, $Res Function(_$_VideoUploadDTO) then) =
      __$$_VideoUploadDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {VideoUploadVideoDTO? videoDTO, List<VideoUploadImageDTO> imageDTO});

  @override
  $VideoUploadVideoDTOCopyWith<$Res>? get videoDTO;
}

/// @nodoc
class __$$_VideoUploadDTOCopyWithImpl<$Res>
    extends _$VideoUploadDTOCopyWithImpl<$Res>
    implements _$$_VideoUploadDTOCopyWith<$Res> {
  __$$_VideoUploadDTOCopyWithImpl(
      _$_VideoUploadDTO _value, $Res Function(_$_VideoUploadDTO) _then)
      : super(_value, (v) => _then(v as _$_VideoUploadDTO));

  @override
  _$_VideoUploadDTO get _value => super._value as _$_VideoUploadDTO;

  @override
  $Res call({
    Object? videoDTO = freezed,
    Object? imageDTO = freezed,
  }) {
    return _then(_$_VideoUploadDTO(
      videoDTO: videoDTO == freezed
          ? _value.videoDTO
          : videoDTO // ignore: cast_nullable_to_non_nullable
              as VideoUploadVideoDTO?,
      imageDTO: imageDTO == freezed
          ? _value._imageDTO
          : imageDTO // ignore: cast_nullable_to_non_nullable
              as List<VideoUploadImageDTO>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoUploadDTO extends _VideoUploadDTO {
  const _$_VideoUploadDTO(
      {this.videoDTO,
      final List<VideoUploadImageDTO> imageDTO = const <VideoUploadImageDTO>[]})
      : _imageDTO = imageDTO,
        super._();

  factory _$_VideoUploadDTO.fromJson(Map<String, dynamic> json) =>
      _$$_VideoUploadDTOFromJson(json);

  @override
  final VideoUploadVideoDTO? videoDTO;
  final List<VideoUploadImageDTO> _imageDTO;
  @override
  @JsonKey()
  List<VideoUploadImageDTO> get imageDTO {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageDTO);
  }

  @override
  String toString() {
    return 'VideoUploadDTO(videoDTO: $videoDTO, imageDTO: $imageDTO)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoUploadDTO &&
            const DeepCollectionEquality().equals(other.videoDTO, videoDTO) &&
            const DeepCollectionEquality().equals(other._imageDTO, _imageDTO));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(videoDTO),
      const DeepCollectionEquality().hash(_imageDTO));

  @JsonKey(ignore: true)
  @override
  _$$_VideoUploadDTOCopyWith<_$_VideoUploadDTO> get copyWith =>
      __$$_VideoUploadDTOCopyWithImpl<_$_VideoUploadDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoUploadDTOToJson(this);
  }
}

abstract class _VideoUploadDTO extends VideoUploadDTO {
  const factory _VideoUploadDTO(
      {final VideoUploadVideoDTO? videoDTO,
      final List<VideoUploadImageDTO> imageDTO}) = _$_VideoUploadDTO;
  const _VideoUploadDTO._() : super._();

  factory _VideoUploadDTO.fromJson(Map<String, dynamic> json) =
      _$_VideoUploadDTO.fromJson;

  @override
  VideoUploadVideoDTO? get videoDTO => throw _privateConstructorUsedError;
  @override
  List<VideoUploadImageDTO> get imageDTO => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoUploadDTOCopyWith<_$_VideoUploadDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
