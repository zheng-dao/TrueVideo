// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_session_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoSessionFileModel _$VideoSessionFileModelFromJson(
    Map<String, dynamic> json) {
  return _VideoSessionFileModel.fromJson(json);
}

/// @nodoc
mixin _$VideoSessionFileModel {
  String get path => throw _privateConstructorUsedError;
  bool get selfie => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoSessionFileModelCopyWith<VideoSessionFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoSessionFileModelCopyWith<$Res> {
  factory $VideoSessionFileModelCopyWith(VideoSessionFileModel value,
          $Res Function(VideoSessionFileModel) then) =
      _$VideoSessionFileModelCopyWithImpl<$Res>;
  $Res call({String path, bool selfie});
}

/// @nodoc
class _$VideoSessionFileModelCopyWithImpl<$Res>
    implements $VideoSessionFileModelCopyWith<$Res> {
  _$VideoSessionFileModelCopyWithImpl(this._value, this._then);

  final VideoSessionFileModel _value;
  // ignore: unused_field
  final $Res Function(VideoSessionFileModel) _then;

  @override
  $Res call({
    Object? path = freezed,
    Object? selfie = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selfie: selfie == freezed
          ? _value.selfie
          : selfie // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoSessionFileModelCopyWith<$Res>
    implements $VideoSessionFileModelCopyWith<$Res> {
  factory _$$_VideoSessionFileModelCopyWith(_$_VideoSessionFileModel value,
          $Res Function(_$_VideoSessionFileModel) then) =
      __$$_VideoSessionFileModelCopyWithImpl<$Res>;
  @override
  $Res call({String path, bool selfie});
}

/// @nodoc
class __$$_VideoSessionFileModelCopyWithImpl<$Res>
    extends _$VideoSessionFileModelCopyWithImpl<$Res>
    implements _$$_VideoSessionFileModelCopyWith<$Res> {
  __$$_VideoSessionFileModelCopyWithImpl(_$_VideoSessionFileModel _value,
      $Res Function(_$_VideoSessionFileModel) _then)
      : super(_value, (v) => _then(v as _$_VideoSessionFileModel));

  @override
  _$_VideoSessionFileModel get _value =>
      super._value as _$_VideoSessionFileModel;

  @override
  $Res call({
    Object? path = freezed,
    Object? selfie = freezed,
  }) {
    return _then(_$_VideoSessionFileModel(
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      selfie: selfie == freezed
          ? _value.selfie
          : selfie // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoSessionFileModel extends _VideoSessionFileModel {
  const _$_VideoSessionFileModel({this.path = "", this.selfie = false})
      : super._();

  factory _$_VideoSessionFileModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoSessionFileModelFromJson(json);

  @override
  @JsonKey()
  final String path;
  @override
  @JsonKey()
  final bool selfie;

  @override
  String toString() {
    return 'VideoSessionFileModel(path: $path, selfie: $selfie)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoSessionFileModel &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.selfie, selfie));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(selfie));

  @JsonKey(ignore: true)
  @override
  _$$_VideoSessionFileModelCopyWith<_$_VideoSessionFileModel> get copyWith =>
      __$$_VideoSessionFileModelCopyWithImpl<_$_VideoSessionFileModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoSessionFileModelToJson(this);
  }
}

abstract class _VideoSessionFileModel extends VideoSessionFileModel {
  const factory _VideoSessionFileModel({final String path, final bool selfie}) =
      _$_VideoSessionFileModel;
  const _VideoSessionFileModel._() : super._();

  factory _VideoSessionFileModel.fromJson(Map<String, dynamic> json) =
      _$_VideoSessionFileModel.fromJson;

  @override
  String get path => throw _privateConstructorUsedError;
  @override
  bool get selfie => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoSessionFileModelCopyWith<_$_VideoSessionFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}
