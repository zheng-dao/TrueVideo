// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'processing_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoEditorProcessingVideoModel _$VideoEditorProcessingVideoModelFromJson(
    Map<String, dynamic> json) {
  return _VideoEditorProcessingVideoModel.fromJson(json);
}

/// @nodoc
mixin _$VideoEditorProcessingVideoModel {
  String get originalPath => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;
  CameraVideoFileModel get video => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoEditorProcessingVideoModelCopyWith<VideoEditorProcessingVideoModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEditorProcessingVideoModelCopyWith<$Res> {
  factory $VideoEditorProcessingVideoModelCopyWith(
          VideoEditorProcessingVideoModel value,
          $Res Function(VideoEditorProcessingVideoModel) then) =
      _$VideoEditorProcessingVideoModelCopyWithImpl<$Res>;
  $Res call(
      {String originalPath,
      bool loading,
      dynamic error,
      CameraVideoFileModel video});

  $CameraVideoFileModelCopyWith<$Res> get video;
}

/// @nodoc
class _$VideoEditorProcessingVideoModelCopyWithImpl<$Res>
    implements $VideoEditorProcessingVideoModelCopyWith<$Res> {
  _$VideoEditorProcessingVideoModelCopyWithImpl(this._value, this._then);

  final VideoEditorProcessingVideoModel _value;
  // ignore: unused_field
  final $Res Function(VideoEditorProcessingVideoModel) _then;

  @override
  $Res call({
    Object? originalPath = freezed,
    Object? loading = freezed,
    Object? error = freezed,
    Object? video = freezed,
  }) {
    return _then(_value.copyWith(
      originalPath: originalPath == freezed
          ? _value.originalPath
          : originalPath // ignore: cast_nullable_to_non_nullable
              as String,
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as CameraVideoFileModel,
    ));
  }

  @override
  $CameraVideoFileModelCopyWith<$Res> get video {
    return $CameraVideoFileModelCopyWith<$Res>(_value.video, (value) {
      return _then(_value.copyWith(video: value));
    });
  }
}

/// @nodoc
abstract class _$$_VideoEditorProcessingVideoModelCopyWith<$Res>
    implements $VideoEditorProcessingVideoModelCopyWith<$Res> {
  factory _$$_VideoEditorProcessingVideoModelCopyWith(
          _$_VideoEditorProcessingVideoModel value,
          $Res Function(_$_VideoEditorProcessingVideoModel) then) =
      __$$_VideoEditorProcessingVideoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String originalPath,
      bool loading,
      dynamic error,
      CameraVideoFileModel video});

  @override
  $CameraVideoFileModelCopyWith<$Res> get video;
}

/// @nodoc
class __$$_VideoEditorProcessingVideoModelCopyWithImpl<$Res>
    extends _$VideoEditorProcessingVideoModelCopyWithImpl<$Res>
    implements _$$_VideoEditorProcessingVideoModelCopyWith<$Res> {
  __$$_VideoEditorProcessingVideoModelCopyWithImpl(
      _$_VideoEditorProcessingVideoModel _value,
      $Res Function(_$_VideoEditorProcessingVideoModel) _then)
      : super(_value, (v) => _then(v as _$_VideoEditorProcessingVideoModel));

  @override
  _$_VideoEditorProcessingVideoModel get _value =>
      super._value as _$_VideoEditorProcessingVideoModel;

  @override
  $Res call({
    Object? originalPath = freezed,
    Object? loading = freezed,
    Object? error = freezed,
    Object? video = freezed,
  }) {
    return _then(_$_VideoEditorProcessingVideoModel(
      originalPath: originalPath == freezed
          ? _value.originalPath
          : originalPath // ignore: cast_nullable_to_non_nullable
              as String,
      loading: loading == freezed
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as CameraVideoFileModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoEditorProcessingVideoModel
    extends _VideoEditorProcessingVideoModel {
  const _$_VideoEditorProcessingVideoModel(
      {this.originalPath = "",
      this.loading = false,
      this.error,
      required this.video})
      : super._();

  factory _$_VideoEditorProcessingVideoModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_VideoEditorProcessingVideoModelFromJson(json);

  @override
  @JsonKey()
  final String originalPath;
  @override
  @JsonKey()
  final bool loading;
  @override
  final dynamic error;
  @override
  final CameraVideoFileModel video;

  @override
  String toString() {
    return 'VideoEditorProcessingVideoModel(originalPath: $originalPath, loading: $loading, error: $error, video: $video)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoEditorProcessingVideoModel &&
            const DeepCollectionEquality()
                .equals(other.originalPath, originalPath) &&
            const DeepCollectionEquality().equals(other.loading, loading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.video, video));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(originalPath),
      const DeepCollectionEquality().hash(loading),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(video));

  @JsonKey(ignore: true)
  @override
  _$$_VideoEditorProcessingVideoModelCopyWith<
          _$_VideoEditorProcessingVideoModel>
      get copyWith => __$$_VideoEditorProcessingVideoModelCopyWithImpl<
          _$_VideoEditorProcessingVideoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoEditorProcessingVideoModelToJson(this);
  }
}

abstract class _VideoEditorProcessingVideoModel
    extends VideoEditorProcessingVideoModel {
  const factory _VideoEditorProcessingVideoModel(
          {final String originalPath,
          final bool loading,
          final dynamic error,
          required final CameraVideoFileModel video}) =
      _$_VideoEditorProcessingVideoModel;
  const _VideoEditorProcessingVideoModel._() : super._();

  factory _VideoEditorProcessingVideoModel.fromJson(Map<String, dynamic> json) =
      _$_VideoEditorProcessingVideoModel.fromJson;

  @override
  String get originalPath => throw _privateConstructorUsedError;
  @override
  bool get loading => throw _privateConstructorUsedError;
  @override
  dynamic get error => throw _privateConstructorUsedError;
  @override
  CameraVideoFileModel get video => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoEditorProcessingVideoModelCopyWith<
          _$_VideoEditorProcessingVideoModel>
      get copyWith => throw _privateConstructorUsedError;
}
