// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'request_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoEditorRequestVideoModel _$VideoEditorRequestVideoModelFromJson(
    Map<String, dynamic> json) {
  return _VideoEditorRequestVideoModel.fromJson(json);
}

/// @nodoc
mixin _$VideoEditorRequestVideoModel {
  String get path => throw _privateConstructorUsedError;
  double get rotation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoEditorRequestVideoModelCopyWith<VideoEditorRequestVideoModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEditorRequestVideoModelCopyWith<$Res> {
  factory $VideoEditorRequestVideoModelCopyWith(
          VideoEditorRequestVideoModel value,
          $Res Function(VideoEditorRequestVideoModel) then) =
      _$VideoEditorRequestVideoModelCopyWithImpl<$Res>;
  $Res call({String path, double rotation});
}

/// @nodoc
class _$VideoEditorRequestVideoModelCopyWithImpl<$Res>
    implements $VideoEditorRequestVideoModelCopyWith<$Res> {
  _$VideoEditorRequestVideoModelCopyWithImpl(this._value, this._then);

  final VideoEditorRequestVideoModel _value;
  // ignore: unused_field
  final $Res Function(VideoEditorRequestVideoModel) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? rotation = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$$_VideoEditorRequestVideoModelCopyWith<$Res>
    implements $VideoEditorRequestVideoModelCopyWith<$Res> {
  factory _$$_VideoEditorRequestVideoModelCopyWith(
          _$_VideoEditorRequestVideoModel value,
          $Res Function(_$_VideoEditorRequestVideoModel) then) =
      __$$_VideoEditorRequestVideoModelCopyWithImpl<$Res>;
  @override
  $Res call({String path, double rotation});
}

/// @nodoc
class __$$_VideoEditorRequestVideoModelCopyWithImpl<$Res>
    extends _$VideoEditorRequestVideoModelCopyWithImpl<$Res>
    implements _$$_VideoEditorRequestVideoModelCopyWith<$Res> {
  __$$_VideoEditorRequestVideoModelCopyWithImpl(
      _$_VideoEditorRequestVideoModel _value,
      $Res Function(_$_VideoEditorRequestVideoModel) _then)
      : super(_value, (v) => _then(v as _$_VideoEditorRequestVideoModel));

  @override
  _$_VideoEditorRequestVideoModel get _value =>
      super._value as _$_VideoEditorRequestVideoModel;

  @override
  $Res call({
    Object? path = freezed,
    Object? rotation = freezed,
  }) {
    return _then(_$_VideoEditorRequestVideoModel(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoEditorRequestVideoModel extends _VideoEditorRequestVideoModel {
  const _$_VideoEditorRequestVideoModel({this.path = "", this.rotation = 0.0})
      : super._();

  factory _$_VideoEditorRequestVideoModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoEditorRequestVideoModelFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final double rotation;

  @override
  String toString() {
    return 'VideoEditorRequestVideoModel(path: $path, rotation: $rotation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoEditorRequestVideoModel &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.rotation, rotation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(rotation));

  @JsonKey(ignore: true)
  @override
  _$$_VideoEditorRequestVideoModelCopyWith<_$_VideoEditorRequestVideoModel>
      get copyWith => __$$_VideoEditorRequestVideoModelCopyWithImpl<
          _$_VideoEditorRequestVideoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoEditorRequestVideoModelToJson(this);
  }
}

abstract class _VideoEditorRequestVideoModel
    extends VideoEditorRequestVideoModel {
  const factory _VideoEditorRequestVideoModel(
      {final String path,
      final double rotation}) = _$_VideoEditorRequestVideoModel;
  const _VideoEditorRequestVideoModel._() : super._();

  factory _VideoEditorRequestVideoModel.fromJson(Map<String, dynamic> json) =
      _$_VideoEditorRequestVideoModel.fromJson;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  double get rotation => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoEditorRequestVideoModelCopyWith<_$_VideoEditorRequestVideoModel>
      get copyWith => throw _privateConstructorUsedError;
}
