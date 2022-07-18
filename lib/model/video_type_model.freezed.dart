// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoTypeModel _$VideoTypeModelFromJson(Map<String, dynamic> json) {
  return _VideoTypeModel.fromJson(json);
}

/// @nodoc
mixin _$VideoTypeModel {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoTypeModelCopyWith<VideoTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoTypeModelCopyWith<$Res> {
  factory $VideoTypeModelCopyWith(
          VideoTypeModel value, $Res Function(VideoTypeModel) then) =
      _$VideoTypeModelCopyWithImpl<$Res>;
  $Res call({String id, String description});
}

/// @nodoc
class _$VideoTypeModelCopyWithImpl<$Res>
    implements $VideoTypeModelCopyWith<$Res> {
  _$VideoTypeModelCopyWithImpl(this._value, this._then);

  final VideoTypeModel _value;
  // ignore: unused_field
  final $Res Function(VideoTypeModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoTypeModelCopyWith<$Res>
    implements $VideoTypeModelCopyWith<$Res> {
  factory _$$_VideoTypeModelCopyWith(
          _$_VideoTypeModel value, $Res Function(_$_VideoTypeModel) then) =
      __$$_VideoTypeModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, String description});
}

/// @nodoc
class __$$_VideoTypeModelCopyWithImpl<$Res>
    extends _$VideoTypeModelCopyWithImpl<$Res>
    implements _$$_VideoTypeModelCopyWith<$Res> {
  __$$_VideoTypeModelCopyWithImpl(
      _$_VideoTypeModel _value, $Res Function(_$_VideoTypeModel) _then)
      : super(_value, (v) => _then(v as _$_VideoTypeModel));

  @override
  _$_VideoTypeModel get _value => super._value as _$_VideoTypeModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_VideoTypeModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VideoTypeModel implements _VideoTypeModel {
  _$_VideoTypeModel({required this.id, this.description = ''});

  factory _$_VideoTypeModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoTypeModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'VideoTypeModel(id: $id, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoTypeModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$_VideoTypeModelCopyWith<_$_VideoTypeModel> get copyWith =>
      __$$_VideoTypeModelCopyWithImpl<_$_VideoTypeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoTypeModelToJson(this);
  }
}

abstract class _VideoTypeModel implements VideoTypeModel {
  factory _VideoTypeModel(
      {required final String id, final String description}) = _$_VideoTypeModel;

  factory _VideoTypeModel.fromJson(Map<String, dynamic> json) =
      _$_VideoTypeModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoTypeModelCopyWith<_$_VideoTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
