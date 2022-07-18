// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tce_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TCEUserModel _$TCEUserModelFromJson(Map<String, dynamic> json) {
  return _TCEUserModel.fromJson(json);
}

/// @nodoc
mixin _$TCEUserModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get middleName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get emailAddress => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  DealerModel? get dealer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TCEUserModelCopyWith<TCEUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TCEUserModelCopyWith<$Res> {
  factory $TCEUserModelCopyWith(
          TCEUserModel value, $Res Function(TCEUserModel) then) =
      _$TCEUserModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String firstName,
      String middleName,
      String lastName,
      String emailAddress,
      String mobileNumber,
      DealerModel? dealer});

  $DealerModelCopyWith<$Res>? get dealer;
}

/// @nodoc
class _$TCEUserModelCopyWithImpl<$Res> implements $TCEUserModelCopyWith<$Res> {
  _$TCEUserModelCopyWithImpl(this._value, this._then);

  final TCEUserModel _value;
  // ignore: unused_field
  final $Res Function(TCEUserModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? emailAddress = freezed,
    Object? mobileNumber = freezed,
    Object? dealer = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: middleName == freezed
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: mobileNumber == freezed
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as DealerModel?,
    ));
  }

  @override
  $DealerModelCopyWith<$Res>? get dealer {
    if (_value.dealer == null) {
      return null;
    }

    return $DealerModelCopyWith<$Res>(_value.dealer!, (value) {
      return _then(_value.copyWith(dealer: value));
    });
  }
}

/// @nodoc
abstract class _$$_TCEUserModelCopyWith<$Res>
    implements $TCEUserModelCopyWith<$Res> {
  factory _$$_TCEUserModelCopyWith(
          _$_TCEUserModel value, $Res Function(_$_TCEUserModel) then) =
      __$$_TCEUserModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String firstName,
      String middleName,
      String lastName,
      String emailAddress,
      String mobileNumber,
      DealerModel? dealer});

  @override
  $DealerModelCopyWith<$Res>? get dealer;
}

/// @nodoc
class __$$_TCEUserModelCopyWithImpl<$Res>
    extends _$TCEUserModelCopyWithImpl<$Res>
    implements _$$_TCEUserModelCopyWith<$Res> {
  __$$_TCEUserModelCopyWithImpl(
      _$_TCEUserModel _value, $Res Function(_$_TCEUserModel) _then)
      : super(_value, (v) => _then(v as _$_TCEUserModel));

  @override
  _$_TCEUserModel get _value => super._value as _$_TCEUserModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? firstName = freezed,
    Object? middleName = freezed,
    Object? lastName = freezed,
    Object? emailAddress = freezed,
    Object? mobileNumber = freezed,
    Object? dealer = freezed,
  }) {
    return _then(_$_TCEUserModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      middleName: middleName == freezed
          ? _value.middleName
          : middleName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: mobileNumber == freezed
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as DealerModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TCEUserModel extends _TCEUserModel {
  const _$_TCEUserModel(
      {this.id = 0,
      this.title = "",
      this.firstName = "",
      this.middleName = "",
      this.lastName = "",
      this.emailAddress = "",
      this.mobileNumber = "",
      this.dealer})
      : super._();

  factory _$_TCEUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_TCEUserModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String middleName;
  @override
  @JsonKey()
  final String lastName;
  @override
  @JsonKey()
  final String emailAddress;
  @override
  @JsonKey()
  final String mobileNumber;
  @override
  final DealerModel? dealer;

  @override
  String toString() {
    return 'TCEUserModel(id: $id, title: $title, firstName: $firstName, middleName: $middleName, lastName: $lastName, emailAddress: $emailAddress, mobileNumber: $mobileNumber, dealer: $dealer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TCEUserModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality()
                .equals(other.middleName, middleName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality()
                .equals(other.emailAddress, emailAddress) &&
            const DeepCollectionEquality()
                .equals(other.mobileNumber, mobileNumber) &&
            const DeepCollectionEquality().equals(other.dealer, dealer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(middleName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(emailAddress),
      const DeepCollectionEquality().hash(mobileNumber),
      const DeepCollectionEquality().hash(dealer));

  @JsonKey(ignore: true)
  @override
  _$$_TCEUserModelCopyWith<_$_TCEUserModel> get copyWith =>
      __$$_TCEUserModelCopyWithImpl<_$_TCEUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TCEUserModelToJson(this);
  }
}

abstract class _TCEUserModel extends TCEUserModel {
  const factory _TCEUserModel(
      {final int id,
      final String title,
      final String firstName,
      final String middleName,
      final String lastName,
      final String emailAddress,
      final String mobileNumber,
      final DealerModel? dealer}) = _$_TCEUserModel;
  const _TCEUserModel._() : super._();

  factory _TCEUserModel.fromJson(Map<String, dynamic> json) =
      _$_TCEUserModel.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get firstName => throw _privateConstructorUsedError;
  @override
  String get middleName => throw _privateConstructorUsedError;
  @override
  String get lastName => throw _privateConstructorUsedError;
  @override
  String get emailAddress => throw _privateConstructorUsedError;
  @override
  String get mobileNumber => throw _privateConstructorUsedError;
  @override
  DealerModel? get dealer => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TCEUserModelCopyWith<_$_TCEUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
