// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'processing_picture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoEditorProcessingPictureModel _$VideoEditorProcessingPictureModelFromJson(
    Map<String, dynamic> json) {
  return _VideoEditorProcessingPictureModel.fromJson(json);
}

/// @nodoc
mixin _$VideoEditorProcessingPictureModel {
  String get originalPath => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;
  CameraPictureFileModel get picture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoEditorProcessingPictureModelCopyWith<VideoEditorProcessingPictureModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEditorProcessingPictureModelCopyWith<$Res> {
  factory $VideoEditorProcessingPictureModelCopyWith(
          VideoEditorProcessingPictureModel value,
          $Res Function(VideoEditorProcessingPictureModel) then) =
      _$VideoEditorProcessingPictureModelCopyWithImpl<$Res>;
  $Res call(
      {String originalPath,
      bool loading,
      dynamic error,
      CameraPictureFileModel picture});

  $CameraPictureFileModelCopyWith<$Res> get picture;
}

/// @nodoc
class _$VideoEditorProcessingPictureModelCopyWithImpl<$Res>
    implements $VideoEditorProcessingPictureModelCopyWith<$Res> {
  _$VideoEditorProcessingPictureModelCopyWithImpl(this._value, this._then);

  final VideoEditorProcessingPictureModel _value;
  // ignore: unused_field
  final $Res Function(VideoEditorProcessingPictureModel) _then;

  @override
  $Res call({
    Object? originalPath = freezed,
    Object? loading = freezed,
    Object? error = freezed,
    Object? picture = freezed,
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
      picture: picture == freezed
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as CameraPictureFileModel,
    ));
  }

  @override
  $CameraPictureFileModelCopyWith<$Res> get picture {
    return $CameraPictureFileModelCopyWith<$Res>(_value.picture, (value) {
      return _then(_value.copyWith(picture: value));
    });
  }
}

/// @nodoc
abstract class _$$_VideoEditorProcessingPictureModelCopyWith<$Res>
    implements $VideoEditorProcessingPictureModelCopyWith<$Res> {
  factory _$$_VideoEditorProcessingPictureModelCopyWith(
          _$_VideoEditorProcessingPictureModel value,
          $Res Function(_$_VideoEditorProcessingPictureModel) then) =
      __$$_VideoEditorProcessingPictureModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String originalPath,
      bool loading,
      dynamic error,
      CameraPictureFileModel picture});

  @override
  $CameraPictureFileModelCopyWith<$Res> get picture;
}

/// @nodoc
class __$$_VideoEditorProcessingPictureModelCopyWithImpl<$Res>
    extends _$VideoEditorProcessingPictureModelCopyWithImpl<$Res>
    implements _$$_VideoEditorProcessingPictureModelCopyWith<$Res> {
  __$$_VideoEditorProcessingPictureModelCopyWithImpl(
      _$_VideoEditorProcessingPictureModel _value,
      $Res Function(_$_VideoEditorProcessingPictureModel) _then)
      : super(_value, (v) => _then(v as _$_VideoEditorProcessingPictureModel));

  @override
  _$_VideoEditorProcessingPictureModel get _value =>
      super._value as _$_VideoEditorProcessingPictureModel;

  @override
  $Res call({
    Object? originalPath = freezed,
    Object? loading = freezed,
    Object? error = freezed,
    Object? picture = freezed,
  }) {
    return _then(_$_VideoEditorProcessingPictureModel(
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
      picture: picture == freezed
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as CameraPictureFileModel,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoEditorProcessingPictureModel
    extends _VideoEditorProcessingPictureModel {
  const _$_VideoEditorProcessingPictureModel(
      {this.originalPath = "",
      this.loading = false,
      this.error,
      required this.picture})
      : super._();

  factory _$_VideoEditorProcessingPictureModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_VideoEditorProcessingPictureModelFromJson(json);

  @override
  @JsonKey()
  final String originalPath;
  @override
  @JsonKey()
  final bool loading;
  @override
  final dynamic error;
  @override
  final CameraPictureFileModel picture;

  @override
  String toString() {
    return 'VideoEditorProcessingPictureModel(originalPath: $originalPath, loading: $loading, error: $error, picture: $picture)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoEditorProcessingPictureModel &&
            const DeepCollectionEquality()
                .equals(other.originalPath, originalPath) &&
            const DeepCollectionEquality().equals(other.loading, loading) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.picture, picture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(originalPath),
      const DeepCollectionEquality().hash(loading),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(picture));

  @JsonKey(ignore: true)
  @override
  _$$_VideoEditorProcessingPictureModelCopyWith<
          _$_VideoEditorProcessingPictureModel>
      get copyWith => __$$_VideoEditorProcessingPictureModelCopyWithImpl<
          _$_VideoEditorProcessingPictureModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoEditorProcessingPictureModelToJson(this);
  }
}

abstract class _VideoEditorProcessingPictureModel
    extends VideoEditorProcessingPictureModel {
  const factory _VideoEditorProcessingPictureModel(
          {final String originalPath,
          final bool loading,
          final dynamic error,
          required final CameraPictureFileModel picture}) =
      _$_VideoEditorProcessingPictureModel;
  const _VideoEditorProcessingPictureModel._() : super._();

  factory _VideoEditorProcessingPictureModel.fromJson(
          Map<String, dynamic> json) =
      _$_VideoEditorProcessingPictureModel.fromJson;

  @override
  String get originalPath => throw _privateConstructorUsedError;
  @override
  bool get loading => throw _privateConstructorUsedError;
  @override
  dynamic get error => throw _privateConstructorUsedError;
  @override
  CameraPictureFileModel get picture => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoEditorProcessingPictureModelCopyWith<
          _$_VideoEditorProcessingPictureModel>
      get copyWith => throw _privateConstructorUsedError;
}
