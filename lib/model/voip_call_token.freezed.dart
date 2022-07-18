// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'voip_call_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VoipCallTokenModel _$VoipCallTokenModelFromJson(Map<String, dynamic> json) {
  return _VoipCallTokenModel.fromJson(json);
}

/// @nodoc
mixin _$VoipCallTokenModel {
  String get identity => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VoipCallTokenModelCopyWith<VoipCallTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoipCallTokenModelCopyWith<$Res> {
  factory $VoipCallTokenModelCopyWith(
          VoipCallTokenModel value, $Res Function(VoipCallTokenModel) then) =
      _$VoipCallTokenModelCopyWithImpl<$Res>;
  $Res call({String identity, String token});
}

/// @nodoc
class _$VoipCallTokenModelCopyWithImpl<$Res>
    implements $VoipCallTokenModelCopyWith<$Res> {
  _$VoipCallTokenModelCopyWithImpl(this._value, this._then);

  final VoipCallTokenModel _value;
  // ignore: unused_field
  final $Res Function(VoipCallTokenModel) _then;

  @override
  $Res call({
    Object? identity = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      identity: identity == freezed
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_VoipCallTokenModelCopyWith<$Res>
    implements $VoipCallTokenModelCopyWith<$Res> {
  factory _$$_VoipCallTokenModelCopyWith(_$_VoipCallTokenModel value,
          $Res Function(_$_VoipCallTokenModel) then) =
      __$$_VoipCallTokenModelCopyWithImpl<$Res>;
  @override
  $Res call({String identity, String token});
}

/// @nodoc
class __$$_VoipCallTokenModelCopyWithImpl<$Res>
    extends _$VoipCallTokenModelCopyWithImpl<$Res>
    implements _$$_VoipCallTokenModelCopyWith<$Res> {
  __$$_VoipCallTokenModelCopyWithImpl(
      _$_VoipCallTokenModel _value, $Res Function(_$_VoipCallTokenModel) _then)
      : super(_value, (v) => _then(v as _$_VoipCallTokenModel));

  @override
  _$_VoipCallTokenModel get _value => super._value as _$_VoipCallTokenModel;

  @override
  $Res call({
    Object? identity = freezed,
    Object? token = freezed,
  }) {
    return _then(_$_VoipCallTokenModel(
      identity: identity == freezed
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VoipCallTokenModel extends _VoipCallTokenModel {
  const _$_VoipCallTokenModel({this.identity = "", this.token = ""})
      : super._();

  factory _$_VoipCallTokenModel.fromJson(Map<String, dynamic> json) =>
      _$$_VoipCallTokenModelFromJson(json);

  @override
  @JsonKey()
  final String identity;
  @override
  @JsonKey()
  final String token;

  @override
  String toString() {
    return 'VoipCallTokenModel(identity: $identity, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VoipCallTokenModel &&
            const DeepCollectionEquality().equals(other.identity, identity) &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identity),
      const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$$_VoipCallTokenModelCopyWith<_$_VoipCallTokenModel> get copyWith =>
      __$$_VoipCallTokenModelCopyWithImpl<_$_VoipCallTokenModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VoipCallTokenModelToJson(this);
  }
}

abstract class _VoipCallTokenModel extends VoipCallTokenModel {
  const factory _VoipCallTokenModel(
      {final String identity, final String token}) = _$_VoipCallTokenModel;
  const _VoipCallTokenModel._() : super._();

  factory _VoipCallTokenModel.fromJson(Map<String, dynamic> json) =
      _$_VoipCallTokenModel.fromJson;

  @override
  String get identity => throw _privateConstructorUsedError;
  @override
  String get token => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VoipCallTokenModelCopyWith<_$_VoipCallTokenModel> get copyWith =>
      throw _privateConstructorUsedError;
}
