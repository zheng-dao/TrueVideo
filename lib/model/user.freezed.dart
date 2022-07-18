// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get publicUserUuid => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  UserDealerModel? get dealer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res>;
  $Res call(
      {String publicUserUuid,
      String firstName,
      String lastName,
      String title,
      String emailAddress,
      String role,
      UserDealerModel? dealer});

  $UserDealerModelCopyWith<$Res>? get dealer;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  final UserModel _value;
  // ignore: unused_field
  final $Res Function(UserModel) _then;

  @override
  $Res call({
    Object? publicUserUuid = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? title = freezed,
    Object? emailAddress = freezed,
    Object? role = freezed,
    Object? dealer = freezed,
  }) {
    return _then(_value.copyWith(
      publicUserUuid: publicUserUuid == freezed
          ? _value.publicUserUuid
          : publicUserUuid // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as UserDealerModel?,
    ));
  }

  @override
  $UserDealerModelCopyWith<$Res>? get dealer {
    if (_value.dealer == null) {
      return null;
    }

    return $UserDealerModelCopyWith<$Res>(_value.dealer!, (value) {
      return _then(_value.copyWith(dealer: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String publicUserUuid,
      String firstName,
      String lastName,
      String title,
      String emailAddress,
      String role,
      UserDealerModel? dealer});

  @override
  $UserDealerModelCopyWith<$Res>? get dealer;
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, (v) => _then(v as _$_UserModel));

  @override
  _$_UserModel get _value => super._value as _$_UserModel;

  @override
  $Res call({
    Object? publicUserUuid = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? title = freezed,
    Object? emailAddress = freezed,
    Object? role = freezed,
    Object? dealer = freezed,
  }) {
    return _then(_$_UserModel(
      publicUserUuid: publicUserUuid == freezed
          ? _value.publicUserUuid
          : publicUserUuid // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as UserDealerModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserModel extends _UserModel {
  const _$_UserModel(
      {this.publicUserUuid = "",
      this.firstName = "",
      this.lastName = "",
      this.title = "",
      this.emailAddress = "",
      this.role = "",
      this.dealer})
      : super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  @JsonKey()
  final String publicUserUuid;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String emailAddress;
  @override
  @JsonKey()
  final String role;
  @override
  final UserDealerModel? dealer;

  @override
  String toString() {
    return 'UserModel(publicUserUuid: $publicUserUuid, firstName: $firstName, lastName: $lastName, title: $title, emailAddress: $emailAddress, role: $role, dealer: $dealer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            const DeepCollectionEquality()
                .equals(other.publicUserUuid, publicUserUuid) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.emailAddress, emailAddress) &&
            const DeepCollectionEquality().equals(other.role, role) &&
            const DeepCollectionEquality().equals(other.dealer, dealer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(publicUserUuid),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(emailAddress),
      const DeepCollectionEquality().hash(role),
      const DeepCollectionEquality().hash(dealer));

  @JsonKey(ignore: true)
  @override
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {final String publicUserUuid,
      final String firstName,
      final String lastName,
      final String title,
      final String emailAddress,
      final String role,
      final UserDealerModel? dealer}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get publicUserUuid => throw _privateConstructorUsedError;
  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get emailAddress => throw _privateConstructorUsedError;
  @override
  String get role => throw _privateConstructorUsedError;
  @override
  UserDealerModel? get dealer => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
