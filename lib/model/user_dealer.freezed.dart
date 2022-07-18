// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_dealer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserDealerModel _$UserDealerModelFromJson(Map<String, dynamic> json) {
  return _UserDealerModel.fromJson(json);
}

/// @nodoc
mixin _$UserDealerModel {
  String get dealerCodeType => throw _privateConstructorUsedError;
  String get publicDealerUuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDealerModelCopyWith<UserDealerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDealerModelCopyWith<$Res> {
  factory $UserDealerModelCopyWith(
          UserDealerModel value, $Res Function(UserDealerModel) then) =
      _$UserDealerModelCopyWithImpl<$Res>;
  $Res call({String dealerCodeType, String publicDealerUuid, String name});
}

/// @nodoc
class _$UserDealerModelCopyWithImpl<$Res>
    implements $UserDealerModelCopyWith<$Res> {
  _$UserDealerModelCopyWithImpl(this._value, this._then);

  final UserDealerModel _value;
  // ignore: unused_field
  final $Res Function(UserDealerModel) _then;

  @override
  $Res call({
    Object? dealerCodeType = freezed,
    Object? publicDealerUuid = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      dealerCodeType: dealerCodeType == freezed
          ? _value.dealerCodeType
          : dealerCodeType // ignore: cast_nullable_to_non_nullable
              as String,
      publicDealerUuid: publicDealerUuid == freezed
          ? _value.publicDealerUuid
          : publicDealerUuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserDealerModelCopyWith<$Res>
    implements $UserDealerModelCopyWith<$Res> {
  factory _$$_UserDealerModelCopyWith(
          _$_UserDealerModel value, $Res Function(_$_UserDealerModel) then) =
      __$$_UserDealerModelCopyWithImpl<$Res>;
  @override
  $Res call({String dealerCodeType, String publicDealerUuid, String name});
}

/// @nodoc
class __$$_UserDealerModelCopyWithImpl<$Res>
    extends _$UserDealerModelCopyWithImpl<$Res>
    implements _$$_UserDealerModelCopyWith<$Res> {
  __$$_UserDealerModelCopyWithImpl(
      _$_UserDealerModel _value, $Res Function(_$_UserDealerModel) _then)
      : super(_value, (v) => _then(v as _$_UserDealerModel));

  @override
  _$_UserDealerModel get _value => super._value as _$_UserDealerModel;

  @override
  $Res call({
    Object? dealerCodeType = freezed,
    Object? publicDealerUuid = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_UserDealerModel(
      dealerCodeType: dealerCodeType == freezed
          ? _value.dealerCodeType
          : dealerCodeType // ignore: cast_nullable_to_non_nullable
              as String,
      publicDealerUuid: publicDealerUuid == freezed
          ? _value.publicDealerUuid
          : publicDealerUuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserDealerModel extends _UserDealerModel {
  const _$_UserDealerModel(
      {this.dealerCodeType = "", this.publicDealerUuid = "", this.name = ""})
      : super._();

  factory _$_UserDealerModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserDealerModelFromJson(json);

  @override
  @JsonKey()
  final String dealerCodeType;
  @override
  @JsonKey()
  final String publicDealerUuid;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'UserDealerModel(dealerCodeType: $dealerCodeType, publicDealerUuid: $publicDealerUuid, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserDealerModel &&
            const DeepCollectionEquality()
                .equals(other.dealerCodeType, dealerCodeType) &&
            const DeepCollectionEquality()
                .equals(other.publicDealerUuid, publicDealerUuid) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(dealerCodeType),
      const DeepCollectionEquality().hash(publicDealerUuid),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_UserDealerModelCopyWith<_$_UserDealerModel> get copyWith =>
      __$$_UserDealerModelCopyWithImpl<_$_UserDealerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserDealerModelToJson(this);
  }
}

abstract class _UserDealerModel extends UserDealerModel {
  const factory _UserDealerModel(
      {final String dealerCodeType,
      final String publicDealerUuid,
      final String name}) = _$_UserDealerModel;
  const _UserDealerModel._() : super._();

  factory _UserDealerModel.fromJson(Map<String, dynamic> json) =
      _$_UserDealerModel.fromJson;

  @override
  String get dealerCodeType => throw _privateConstructorUsedError;
  @override
  String get publicDealerUuid => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserDealerModelCopyWith<_$_UserDealerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
