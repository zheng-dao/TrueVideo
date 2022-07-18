// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'camera_video_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CameraVideoFileModel _$CameraVideoFileModelFromJson(Map<String, dynamic> json) {
  return _CameraVideoFileModel.fromJson(json);
}

/// @nodoc
mixin _$CameraVideoFileModel {
  VideoInfoModel get info => throw _privateConstructorUsedError;
  String get thumbnailPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CameraVideoFileModelCopyWith<CameraVideoFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraVideoFileModelCopyWith<$Res> {
  factory $CameraVideoFileModelCopyWith(CameraVideoFileModel value,
          $Res Function(CameraVideoFileModel) then) =
      _$CameraVideoFileModelCopyWithImpl<$Res>;
  $Res call({VideoInfoModel info, String thumbnailPath});

  $VideoInfoModelCopyWith<$Res> get info;
}

/// @nodoc
class _$CameraVideoFileModelCopyWithImpl<$Res>
    implements $CameraVideoFileModelCopyWith<$Res> {
  _$CameraVideoFileModelCopyWithImpl(this._value, this._then);

  final CameraVideoFileModel _value;
  // ignore: unused_field
  final $Res Function(CameraVideoFileModel) _then;

  @override
  $Res call({
    Object? info = freezed,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_value.copyWith(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as VideoInfoModel,
      thumbnailPath: thumbnailPath == freezed
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $VideoInfoModelCopyWith<$Res> get info {
    return $VideoInfoModelCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
abstract class _$$_CameraVideoFileModelCopyWith<$Res>
    implements $CameraVideoFileModelCopyWith<$Res> {
  factory _$$_CameraVideoFileModelCopyWith(_$_CameraVideoFileModel value,
          $Res Function(_$_CameraVideoFileModel) then) =
      __$$_CameraVideoFileModelCopyWithImpl<$Res>;
  @override
  $Res call({VideoInfoModel info, String thumbnailPath});

  @override
  $VideoInfoModelCopyWith<$Res> get info;
}

/// @nodoc
class __$$_CameraVideoFileModelCopyWithImpl<$Res>
    extends _$CameraVideoFileModelCopyWithImpl<$Res>
    implements _$$_CameraVideoFileModelCopyWith<$Res> {
  __$$_CameraVideoFileModelCopyWithImpl(_$_CameraVideoFileModel _value,
      $Res Function(_$_CameraVideoFileModel) _then)
      : super(_value, (v) => _then(v as _$_CameraVideoFileModel));

  @override
  _$_CameraVideoFileModel get _value => super._value as _$_CameraVideoFileModel;

  @override
  $Res call({
    Object? info = freezed,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_$_CameraVideoFileModel(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as VideoInfoModel,
      thumbnailPath: thumbnailPath == freezed
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CameraVideoFileModel extends _CameraVideoFileModel {
  const _$_CameraVideoFileModel({required this.info, this.thumbnailPath = ""})
      : super._();

  factory _$_CameraVideoFileModel.fromJson(Map<String, dynamic> json) =>
      _$$_CameraVideoFileModelFromJson(json);

  @override
  final VideoInfoModel info;
  @override
  @JsonKey()
  final String thumbnailPath;

  @override
  String toString() {
    return 'CameraVideoFileModel(info: $info, thumbnailPath: $thumbnailPath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CameraVideoFileModel &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailPath, thumbnailPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(thumbnailPath));

  @JsonKey(ignore: true)
  @override
  _$$_CameraVideoFileModelCopyWith<_$_CameraVideoFileModel> get copyWith =>
      __$$_CameraVideoFileModelCopyWithImpl<_$_CameraVideoFileModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CameraVideoFileModelToJson(this);
  }
}

abstract class _CameraVideoFileModel extends CameraVideoFileModel {
  const factory _CameraVideoFileModel(
      {required final VideoInfoModel info,
      final String thumbnailPath}) = _$_CameraVideoFileModel;
  const _CameraVideoFileModel._() : super._();

  factory _CameraVideoFileModel.fromJson(Map<String, dynamic> json) =
      _$_CameraVideoFileModel.fromJson;

  @override
  VideoInfoModel get info => throw _privateConstructorUsedError;
  @override
  String get thumbnailPath => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CameraVideoFileModelCopyWith<_$_CameraVideoFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}
