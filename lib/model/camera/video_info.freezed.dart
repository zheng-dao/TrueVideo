// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoInfoModel _$VideoInfoModelFromJson(Map<String, dynamic> json) {
  return _VideoInfoModel.fromJson(json);
}

/// @nodoc
mixin _$VideoInfoModel {
  String get path => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  int get durationMillis => throw _privateConstructorUsedError;
  int get rotation => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoInfoModelCopyWith<VideoInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoInfoModelCopyWith<$Res> {
  factory $VideoInfoModelCopyWith(
          VideoInfoModel value, $Res Function(VideoInfoModel) then) =
      _$VideoInfoModelCopyWithImpl<$Res>;
  $Res call(
      {String path,
      double width,
      double height,
      int durationMillis,
      int rotation,
      int size});
}

/// @nodoc
class _$VideoInfoModelCopyWithImpl<$Res>
    implements $VideoInfoModelCopyWith<$Res> {
  _$VideoInfoModelCopyWithImpl(this._value, this._then);

  final VideoInfoModel _value;
  // ignore: unused_field
  final $Res Function(VideoInfoModel) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? durationMillis = freezed,
    Object? rotation = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      durationMillis: durationMillis == freezed
          ? _value.durationMillis
          : durationMillis // ignore: cast_nullable_to_non_nullable
              as int,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoInfoModelCopyWith<$Res>
    implements $VideoInfoModelCopyWith<$Res> {
  factory _$$_VideoInfoModelCopyWith(
          _$_VideoInfoModel value, $Res Function(_$_VideoInfoModel) then) =
      __$$_VideoInfoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String path,
      double width,
      double height,
      int durationMillis,
      int rotation,
      int size});
}

/// @nodoc
class __$$_VideoInfoModelCopyWithImpl<$Res>
    extends _$VideoInfoModelCopyWithImpl<$Res>
    implements _$$_VideoInfoModelCopyWith<$Res> {
  __$$_VideoInfoModelCopyWithImpl(
      _$_VideoInfoModel _value, $Res Function(_$_VideoInfoModel) _then)
      : super(_value, (v) => _then(v as _$_VideoInfoModel));

  @override
  _$_VideoInfoModel get _value => super._value as _$_VideoInfoModel;

  @override
  $Res call({
    Object? path = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? durationMillis = freezed,
    Object? rotation = freezed,
    Object? size = freezed,
  }) {
    return _then(_$_VideoInfoModel(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      durationMillis: durationMillis == freezed
          ? _value.durationMillis
          : durationMillis // ignore: cast_nullable_to_non_nullable
              as int,
      rotation: rotation == freezed
          ? _value.rotation
          : rotation // ignore: cast_nullable_to_non_nullable
              as int,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoInfoModel extends _VideoInfoModel {
  const _$_VideoInfoModel(
      {this.path = "",
      this.width = 0.0,
      this.height = 0.0,
      this.durationMillis = 0,
      this.rotation = 0,
      this.size = 0})
      : super._();

  factory _$_VideoInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoInfoModelFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final double width;
  @override
  @JsonKey()
  final double height;
  @override
  @JsonKey()
  final int durationMillis;
  @override
  @JsonKey()
  final int rotation;
  @override
  @JsonKey()
  final int size;

  @override
  String toString() {
    return 'VideoInfoModel(path: $path, width: $width, height: $height, durationMillis: $durationMillis, rotation: $rotation, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoInfoModel &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality()
                .equals(other.durationMillis, durationMillis) &&
            const DeepCollectionEquality().equals(other.rotation, rotation) &&
            const DeepCollectionEquality().equals(other.size, size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(durationMillis),
      const DeepCollectionEquality().hash(rotation),
      const DeepCollectionEquality().hash(size));

  @JsonKey(ignore: true)
  @override
  _$$_VideoInfoModelCopyWith<_$_VideoInfoModel> get copyWith =>
      __$$_VideoInfoModelCopyWithImpl<_$_VideoInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoInfoModelToJson(this);
  }
}

abstract class _VideoInfoModel extends VideoInfoModel {
  const factory _VideoInfoModel(
      {final String path,
      final double width,
      final double height,
      final int durationMillis,
      final int rotation,
      final int size}) = _$_VideoInfoModel;
  const _VideoInfoModel._() : super._();

  factory _VideoInfoModel.fromJson(Map<String, dynamic> json) =
      _$_VideoInfoModel.fromJson;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  double get width => throw _privateConstructorUsedError;
  @override
  double get height => throw _privateConstructorUsedError;
  @override
  int get durationMillis => throw _privateConstructorUsedError;
  @override
  int get rotation => throw _privateConstructorUsedError;
  @override
  int get size => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoInfoModelCopyWith<_$_VideoInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
