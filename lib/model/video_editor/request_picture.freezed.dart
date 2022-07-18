// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'request_picture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoEditorRequestPictureModel _$VideoEditorRequestPictureModelFromJson(
    Map<String, dynamic> json) {
  return _VideoEditorRequestPictureModel.fromJson(json);
}

/// @nodoc
mixin _$VideoEditorRequestPictureModel {
  String get path => throw _privateConstructorUsedError;
  double get rotation => throw _privateConstructorUsedError;
  bool get flipHorizontal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoEditorRequestPictureModelCopyWith<VideoEditorRequestPictureModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEditorRequestPictureModelCopyWith<$Res> {
  factory $VideoEditorRequestPictureModelCopyWith(
          VideoEditorRequestPictureModel value,
          $Res Function(VideoEditorRequestPictureModel) then) =
      _$VideoEditorRequestPictureModelCopyWithImpl<$Res>;
  $Res call({String path, double rotation, bool flipHorizontal});
}

/// @nodoc
class _$VideoEditorRequestPictureModelCopyWithImpl<$Res>
    implements $VideoEditorRequestPictureModelCopyWith<$Res> {
  _$VideoEditorRequestPictureModelCopyWithImpl(this._value, this._then);

  final VideoEditorRequestPictureModel _value;
  // ignore: unused_field
  final $Res Function(VideoEditorRequestPictureModel) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? rotation = freezed,
    Object? flipHorizontal = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      flipHorizontal: flipHorizontal == freezed
          ? _value.flipHorizontal
          : flipHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoEditorRequestPictureModelCopyWith<$Res>
    implements $VideoEditorRequestPictureModelCopyWith<$Res> {
  factory _$$_VideoEditorRequestPictureModelCopyWith(
          _$_VideoEditorRequestPictureModel value,
          $Res Function(_$_VideoEditorRequestPictureModel) then) =
      __$$_VideoEditorRequestPictureModelCopyWithImpl<$Res>;
  @override
  $Res call({String path, double rotation, bool flipHorizontal});
}

/// @nodoc
class __$$_VideoEditorRequestPictureModelCopyWithImpl<$Res>
    extends _$VideoEditorRequestPictureModelCopyWithImpl<$Res>
    implements _$$_VideoEditorRequestPictureModelCopyWith<$Res> {
  __$$_VideoEditorRequestPictureModelCopyWithImpl(
      _$_VideoEditorRequestPictureModel _value,
      $Res Function(_$_VideoEditorRequestPictureModel) _then)
      : super(_value, (v) => _then(v as _$_VideoEditorRequestPictureModel));

  @override
  _$_VideoEditorRequestPictureModel get _value =>
      super._value as _$_VideoEditorRequestPictureModel;

  @override
  $Res call({
    Object? path = freezed,
    Object? rotation = freezed,
    Object? flipHorizontal = freezed,
  }) {
    return _then(_$_VideoEditorRequestPictureModel(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
      flipHorizontal: flipHorizontal == freezed
          ? _value.flipHorizontal
          : flipHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoEditorRequestPictureModel
    extends _VideoEditorRequestPictureModel {
  const _$_VideoEditorRequestPictureModel(
      {this.path = "", this.rotation = 0.0, this.flipHorizontal = false})
      : super._();

  factory _$_VideoEditorRequestPictureModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_VideoEditorRequestPictureModelFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final double rotation;
  @override
  @JsonKey()
  final bool flipHorizontal;

  @override
  String toString() {
    return 'VideoEditorRequestPictureModel(path: $path, rotation: $rotation, flipHorizontal: $flipHorizontal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoEditorRequestPictureModel &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.rotation, rotation) &&
            const DeepCollectionEquality()
                .equals(other.flipHorizontal, flipHorizontal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(rotation),
      const DeepCollectionEquality().hash(flipHorizontal));

  @JsonKey(ignore: true)
  @override
  _$$_VideoEditorRequestPictureModelCopyWith<_$_VideoEditorRequestPictureModel>
      get copyWith => __$$_VideoEditorRequestPictureModelCopyWithImpl<
          _$_VideoEditorRequestPictureModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoEditorRequestPictureModelToJson(this);
  }
}

abstract class _VideoEditorRequestPictureModel
    extends VideoEditorRequestPictureModel {
  const factory _VideoEditorRequestPictureModel(
      {final String path,
      final double rotation,
      final bool flipHorizontal}) = _$_VideoEditorRequestPictureModel;
  const _VideoEditorRequestPictureModel._() : super._();

  factory _VideoEditorRequestPictureModel.fromJson(Map<String, dynamic> json) =
      _$_VideoEditorRequestPictureModel.fromJson;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  double get rotation => throw _privateConstructorUsedError;
  @override
  bool get flipHorizontal => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoEditorRequestPictureModelCopyWith<_$_VideoEditorRequestPictureModel>
      get copyWith => throw _privateConstructorUsedError;
}
