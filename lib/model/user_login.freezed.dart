// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_login.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) {
  return _UserLoginModel.fromJson(json);
}

/// @nodoc
mixin _$UserLoginModel {
  String get publicUserUuid => throw _privateConstructorUsedError;
  String get completeName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLoginModelCopyWith<UserLoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLoginModelCopyWith<$Res> {
  factory $UserLoginModelCopyWith(
          UserLoginModel value, $Res Function(UserLoginModel) then) =
      _$UserLoginModelCopyWithImpl<$Res>;
  $Res call({String publicUserUuid, String completeName});
}

/// @nodoc
class _$UserLoginModelCopyWithImpl<$Res>
    implements $UserLoginModelCopyWith<$Res> {
  _$UserLoginModelCopyWithImpl(this._value, this._then);

  final UserLoginModel _value;
  // ignore: unused_field
  final $Res Function(UserLoginModel) _then;

  @override
  $Res call({
    Object? publicUserUuid = freezed,
    Object? completeName = freezed,
  }) {
    return _then(_value.copyWith(
      publicUserUuid: publicUserUuid == freezed
          ? _value.publicUserUuid
          : publicUserUuid // ignore: cast_nullable_to_non_nullable
              as String,
      completeName: completeName == freezed
          ? _value.completeName
          : completeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserLoginModelCopyWith<$Res>
    implements $UserLoginModelCopyWith<$Res> {
  factory _$$_UserLoginModelCopyWith(
          _$_UserLoginModel value, $Res Function(_$_UserLoginModel) then) =
      __$$_UserLoginModelCopyWithImpl<$Res>;
  @override
  $Res call({String publicUserUuid, String completeName});
}

/// @nodoc
class __$$_UserLoginModelCopyWithImpl<$Res>
    extends _$UserLoginModelCopyWithImpl<$Res>
    implements _$$_UserLoginModelCopyWith<$Res> {
  __$$_UserLoginModelCopyWithImpl(
      _$_UserLoginModel _value, $Res Function(_$_UserLoginModel) _then)
      : super(_value, (v) => _then(v as _$_UserLoginModel));

  @override
  _$_UserLoginModel get _value => super._value as _$_UserLoginModel;

  @override
  $Res call({
    Object? publicUserUuid = freezed,
    Object? completeName = freezed,
  }) {
    return _then(_$_UserLoginModel(
      publicUserUuid: publicUserUuid == freezed
          ? _value.publicUserUuid
          : publicUserUuid // ignore: cast_nullable_to_non_nullable
              as String,
      completeName: completeName == freezed
          ? _value.completeName
          : completeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserLoginModel extends _UserLoginModel {
  const _$_UserLoginModel({this.publicUserUuid = "", this.completeName = ""})
      : super._();

  factory _$_UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserLoginModelFromJson(json);

  @override
  @JsonKey()
  final String publicUserUuid;
  @override
  @JsonKey()
  final String completeName;

  @override
  String toString() {
    return 'UserLoginModel(publicUserUuid: $publicUserUuid, completeName: $completeName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserLoginModel &&
            const DeepCollectionEquality()
                .equals(other.publicUserUuid, publicUserUuid) &&
            const DeepCollectionEquality()
                .equals(other.completeName, completeName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(publicUserUuid),
      const DeepCollectionEquality().hash(completeName));

  @JsonKey(ignore: true)
  @override
  _$$_UserLoginModelCopyWith<_$_UserLoginModel> get copyWith =>
      __$$_UserLoginModelCopyWithImpl<_$_UserLoginModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserLoginModelToJson(this);
  }
}

abstract class _UserLoginModel extends UserLoginModel {
  const factory _UserLoginModel(
      {final String publicUserUuid,
      final String completeName}) = _$_UserLoginModel;
  const _UserLoginModel._() : super._();

  factory _UserLoginModel.fromJson(Map<String, dynamic> json) =
      _$_UserLoginModel.fromJson;

  @override
  String get publicUserUuid => throw _privateConstructorUsedError;
  @override
  String get completeName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserLoginModelCopyWith<_$_UserLoginModel> get copyWith =>
      throw _privateConstructorUsedError;
}
