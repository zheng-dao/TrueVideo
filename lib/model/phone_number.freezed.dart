// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'phone_number.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhoneNumberModel _$PhoneNumberModelFromJson(Map<String, dynamic> json) {
  return _PhoneNumberModel.fromJson(json);
}

/// @nodoc
mixin _$PhoneNumberModel {
  PhoneNumberCountryModel get country => throw _privateConstructorUsedError;
  String get e164 => throw _privateConstructorUsedError;
  String get formattedNationalNumber => throw _privateConstructorUsedError;
  String get formattedInternationalNumber => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  bool get mobileNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhoneNumberModelCopyWith<PhoneNumberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneNumberModelCopyWith<$Res> {
  factory $PhoneNumberModelCopyWith(
          PhoneNumberModel value, $Res Function(PhoneNumberModel) then) =
      _$PhoneNumberModelCopyWithImpl<$Res>;
  $Res call(
      {PhoneNumberCountryModel country,
      String e164,
      String formattedNationalNumber,
      String formattedInternationalNumber,
      String number,
      bool mobileNumber});

  $PhoneNumberCountryModelCopyWith<$Res> get country;
}

/// @nodoc
class _$PhoneNumberModelCopyWithImpl<$Res>
    implements $PhoneNumberModelCopyWith<$Res> {
  _$PhoneNumberModelCopyWithImpl(this._value, this._then);

  final PhoneNumberModel _value;
  // ignore: unused_field
  final $Res Function(PhoneNumberModel) _then;

  @override
  $Res call({
    Object? country = freezed,
    Object? e164 = freezed,
    Object? formattedNationalNumber = freezed,
    Object? formattedInternationalNumber = freezed,
    Object? number = freezed,
    Object? mobileNumber = freezed,
  }) {
    return _then(_value.copyWith(
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as PhoneNumberCountryModel,
      e164: e164 == freezed
          ? _value.e164
          : e164 // ignore: cast_nullable_to_non_nullable
              as String,
      formattedNationalNumber: formattedNationalNumber == freezed
          ? _value.formattedNationalNumber
          : formattedNationalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      formattedInternationalNumber: formattedInternationalNumber == freezed
          ? _value.formattedInternationalNumber
          : formattedInternationalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: mobileNumber == freezed
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $PhoneNumberCountryModelCopyWith<$Res> get country {
    return $PhoneNumberCountryModelCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value));
    });
  }
}

/// @nodoc
abstract class _$$_PhoneNumberModelCopyWith<$Res>
    implements $PhoneNumberModelCopyWith<$Res> {
  factory _$$_PhoneNumberModelCopyWith(
          _$_PhoneNumberModel value, $Res Function(_$_PhoneNumberModel) then) =
      __$$_PhoneNumberModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {PhoneNumberCountryModel country,
      String e164,
      String formattedNationalNumber,
      String formattedInternationalNumber,
      String number,
      bool mobileNumber});

  @override
  $PhoneNumberCountryModelCopyWith<$Res> get country;
}

/// @nodoc
class __$$_PhoneNumberModelCopyWithImpl<$Res>
    extends _$PhoneNumberModelCopyWithImpl<$Res>
    implements _$$_PhoneNumberModelCopyWith<$Res> {
  __$$_PhoneNumberModelCopyWithImpl(
      _$_PhoneNumberModel _value, $Res Function(_$_PhoneNumberModel) _then)
      : super(_value, (v) => _then(v as _$_PhoneNumberModel));

  @override
  _$_PhoneNumberModel get _value => super._value as _$_PhoneNumberModel;

  @override
  $Res call({
    Object? country = freezed,
    Object? e164 = freezed,
    Object? formattedNationalNumber = freezed,
    Object? formattedInternationalNumber = freezed,
    Object? number = freezed,
    Object? mobileNumber = freezed,
  }) {
    return _then(_$_PhoneNumberModel(
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as PhoneNumberCountryModel,
      e164: e164 == freezed
          ? _value.e164
          : e164 // ignore: cast_nullable_to_non_nullable
              as String,
      formattedNationalNumber: formattedNationalNumber == freezed
          ? _value.formattedNationalNumber
          : formattedNationalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      formattedInternationalNumber: formattedInternationalNumber == freezed
          ? _value.formattedInternationalNumber
          : formattedInternationalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: mobileNumber == freezed
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_PhoneNumberModel extends _PhoneNumberModel {
  const _$_PhoneNumberModel(
      {this.country = const PhoneNumberCountryModel(),
      this.e164 = "",
      this.formattedNationalNumber = "",
      this.formattedInternationalNumber = "",
      this.number = "",
      this.mobileNumber = false})
      : super._();

  factory _$_PhoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$$_PhoneNumberModelFromJson(json);

  @override
  @JsonKey()
  final PhoneNumberCountryModel country;
  @override
  @JsonKey()
  final String e164;
  @override
  @JsonKey()
  final String formattedNationalNumber;
  @override
  @JsonKey()
  final String formattedInternationalNumber;
  @override
  @JsonKey()
  final String number;
  @override
  @JsonKey()
  final bool mobileNumber;

  @override
  String toString() {
    return 'PhoneNumberModel(country: $country, e164: $e164, formattedNationalNumber: $formattedNationalNumber, formattedInternationalNumber: $formattedInternationalNumber, number: $number, mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhoneNumberModel &&
            const DeepCollectionEquality().equals(other.country, country) &&
            const DeepCollectionEquality().equals(other.e164, e164) &&
            const DeepCollectionEquality().equals(
                other.formattedNationalNumber, formattedNationalNumber) &&
            const DeepCollectionEquality().equals(
                other.formattedInternationalNumber,
                formattedInternationalNumber) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality()
                .equals(other.mobileNumber, mobileNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(country),
      const DeepCollectionEquality().hash(e164),
      const DeepCollectionEquality().hash(formattedNationalNumber),
      const DeepCollectionEquality().hash(formattedInternationalNumber),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(mobileNumber));

  @JsonKey(ignore: true)
  @override
  _$$_PhoneNumberModelCopyWith<_$_PhoneNumberModel> get copyWith =>
      __$$_PhoneNumberModelCopyWithImpl<_$_PhoneNumberModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhoneNumberModelToJson(this);
  }
}

abstract class _PhoneNumberModel extends PhoneNumberModel {
  const factory _PhoneNumberModel(
      {final PhoneNumberCountryModel country,
      final String e164,
      final String formattedNationalNumber,
      final String formattedInternationalNumber,
      final String number,
      final bool mobileNumber}) = _$_PhoneNumberModel;
  const _PhoneNumberModel._() : super._();

  factory _PhoneNumberModel.fromJson(Map<String, dynamic> json) =
      _$_PhoneNumberModel.fromJson;

  @override
  PhoneNumberCountryModel get country => throw _privateConstructorUsedError;
  @override
  String get e164 => throw _privateConstructorUsedError;
  @override
  String get formattedNationalNumber => throw _privateConstructorUsedError;
  @override
  String get formattedInternationalNumber => throw _privateConstructorUsedError;
  @override
  String get number => throw _privateConstructorUsedError;
  @override
  bool get mobileNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PhoneNumberModelCopyWith<_$_PhoneNumberModel> get copyWith =>
      throw _privateConstructorUsedError;
}
