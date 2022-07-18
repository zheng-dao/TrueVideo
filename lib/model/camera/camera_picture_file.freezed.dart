// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'camera_picture_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CameraPictureFileModel _$CameraPictureFileModelFromJson(
    Map<String, dynamic> json) {
  return _CameraPictureFileModel.fromJson(json);
}

/// @nodoc
mixin _$CameraPictureFileModel {
  String get path => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CameraPictureFileModelCopyWith<CameraPictureFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraPictureFileModelCopyWith<$Res> {
  factory $CameraPictureFileModelCopyWith(CameraPictureFileModel value,
          $Res Function(CameraPictureFileModel) then) =
      _$CameraPictureFileModelCopyWithImpl<$Res>;
  $Res call({String path, int size, double width, double height});
}

/// @nodoc
class _$CameraPictureFileModelCopyWithImpl<$Res>
    implements $CameraPictureFileModelCopyWith<$Res> {
  _$CameraPictureFileModelCopyWithImpl(this._value, this._then);

  final CameraPictureFileModel _value;
  // ignore: unused_field
  final $Res Function(CameraPictureFileModel) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? size = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_CameraPictureFileModelCopyWith<$Res>
    implements $CameraPictureFileModelCopyWith<$Res> {
  factory _$$_CameraPictureFileModelCopyWith(_$_CameraPictureFileModel value,
          $Res Function(_$_CameraPictureFileModel) then) =
      __$$_CameraPictureFileModelCopyWithImpl<$Res>;
  @override
  $Res call({String path, int size, double width, double height});
}

/// @nodoc
class __$$_CameraPictureFileModelCopyWithImpl<$Res>
    extends _$CameraPictureFileModelCopyWithImpl<$Res>
    implements _$$_CameraPictureFileModelCopyWith<$Res> {
  __$$_CameraPictureFileModelCopyWithImpl(_$_CameraPictureFileModel _value,
      $Res Function(_$_CameraPictureFileModel) _then)
      : super(_value, (v) => _then(v as _$_CameraPictureFileModel));

  @override
  _$_CameraPictureFileModel get _value =>
      super._value as _$_CameraPictureFileModel;

  @override
  $Res call({
    Object? path = freezed,
    Object? size = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$_CameraPictureFileModel(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CameraPictureFileModel extends _CameraPictureFileModel {
  const _$_CameraPictureFileModel(
      {this.path = "", this.size = 0, this.width = 0.0, this.height = 0.0})
      : super._();

  factory _$_CameraPictureFileModel.fromJson(Map<String, dynamic> json) =>
      _$$_CameraPictureFileModelFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final int size;
  @override
  @JsonKey()
  final double width;
  @override
  @JsonKey()
  final double height;

  @override
  String toString() {
    return 'CameraPictureFileModel(path: $path, size: $size, width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CameraPictureFileModel &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(height));

  @JsonKey(ignore: true)
  @override
  _$$_CameraPictureFileModelCopyWith<_$_CameraPictureFileModel> get copyWith =>
      __$$_CameraPictureFileModelCopyWithImpl<_$_CameraPictureFileModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CameraPictureFileModelToJson(this);
  }
}

abstract class _CameraPictureFileModel extends CameraPictureFileModel {
  const factory _CameraPictureFileModel(
      {final String path,
      final int size,
      final double width,
      final double height}) = _$_CameraPictureFileModel;
  const _CameraPictureFileModel._() : super._();

  factory _CameraPictureFileModel.fromJson(Map<String, dynamic> json) =
      _$_CameraPictureFileModel.fromJson;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  int get size => throw _privateConstructorUsedError;
  @override
  double get width => throw _privateConstructorUsedError;
  @override
  double get height => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CameraPictureFileModelCopyWith<_$_CameraPictureFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}
