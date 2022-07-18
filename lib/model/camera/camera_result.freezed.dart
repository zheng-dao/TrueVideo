// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'camera_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CameraResultModel _$CameraResultModelFromJson(Map<String, dynamic> json) {
  return _CameraResultModel.fromJson(json);
}

/// @nodoc
mixin _$CameraResultModel {
  CameraVideoFileModel get video => throw _privateConstructorUsedError;
  List<CameraPictureFileModel> get pictures =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CameraResultModelCopyWith<CameraResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraResultModelCopyWith<$Res> {
  factory $CameraResultModelCopyWith(
          CameraResultModel value, $Res Function(CameraResultModel) then) =
      _$CameraResultModelCopyWithImpl<$Res>;
  $Res call(
      {CameraVideoFileModel video, List<CameraPictureFileModel> pictures});

  $CameraVideoFileModelCopyWith<$Res> get video;
}

/// @nodoc
class _$CameraResultModelCopyWithImpl<$Res>
    implements $CameraResultModelCopyWith<$Res> {
  _$CameraResultModelCopyWithImpl(this._value, this._then);

  final CameraResultModel _value;
  // ignore: unused_field
  final $Res Function(CameraResultModel) _then;

  @override
  $Res call({
    Object? video = freezed,
    Object? pictures = freezed,
  }) {
    return _then(_value.copyWith(
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as CameraVideoFileModel,
      pictures: pictures == freezed
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<CameraPictureFileModel>,
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
abstract class _$$_CameraResultModelCopyWith<$Res>
    implements $CameraResultModelCopyWith<$Res> {
  factory _$$_CameraResultModelCopyWith(_$_CameraResultModel value,
          $Res Function(_$_CameraResultModel) then) =
      __$$_CameraResultModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {CameraVideoFileModel video, List<CameraPictureFileModel> pictures});

  @override
  $CameraVideoFileModelCopyWith<$Res> get video;
}

/// @nodoc
class __$$_CameraResultModelCopyWithImpl<$Res>
    extends _$CameraResultModelCopyWithImpl<$Res>
    implements _$$_CameraResultModelCopyWith<$Res> {
  __$$_CameraResultModelCopyWithImpl(
      _$_CameraResultModel _value, $Res Function(_$_CameraResultModel) _then)
      : super(_value, (v) => _then(v as _$_CameraResultModel));

  @override
  _$_CameraResultModel get _value => super._value as _$_CameraResultModel;

  @override
  $Res call({
    Object? video = freezed,
    Object? pictures = freezed,
  }) {
    return _then(_$_CameraResultModel(
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as CameraVideoFileModel,
      pictures: pictures == freezed
          ? _value._pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<CameraPictureFileModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_CameraResultModel extends _CameraResultModel {
  const _$_CameraResultModel(
      {required this.video,
      final List<CameraPictureFileModel> pictures =
          const <CameraPictureFileModel>[]})
      : _pictures = pictures,
        super._();

  factory _$_CameraResultModel.fromJson(Map<String, dynamic> json) =>
      _$$_CameraResultModelFromJson(json);

  @override
  final CameraVideoFileModel video;
  final List<CameraPictureFileModel> _pictures;
  @override
  @JsonKey()
  List<CameraPictureFileModel> get pictures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictures);
  }

  @override
  String toString() {
    return 'CameraResultModel(video: $video, pictures: $pictures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CameraResultModel &&
            const DeepCollectionEquality().equals(other.video, video) &&
            const DeepCollectionEquality().equals(other._pictures, _pictures));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(video),
      const DeepCollectionEquality().hash(_pictures));

  @JsonKey(ignore: true)
  @override
  _$$_CameraResultModelCopyWith<_$_CameraResultModel> get copyWith =>
      __$$_CameraResultModelCopyWithImpl<_$_CameraResultModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CameraResultModelToJson(this);
  }
}

abstract class _CameraResultModel extends CameraResultModel {
  const factory _CameraResultModel(
      {required final CameraVideoFileModel video,
      final List<CameraPictureFileModel> pictures}) = _$_CameraResultModel;
  const _CameraResultModel._() : super._();

  factory _CameraResultModel.fromJson(Map<String, dynamic> json) =
      _$_CameraResultModel.fromJson;

  @override
  CameraVideoFileModel get video => throw _privateConstructorUsedError;
  @override
  List<CameraPictureFileModel> get pictures =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CameraResultModelCopyWith<_$_CameraResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}
