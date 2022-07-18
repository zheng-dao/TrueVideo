// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_phone.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessagePhoneModel _$MessagePhoneModelFromJson(Map<String, dynamic> json) {
  return _MessagePhoneModel.fromJson(json);
}

/// @nodoc
mixin _$MessagePhoneModel {
  String get countryCode => throw _privateConstructorUsedError;
  String get isoCode => throw _privateConstructorUsedError;
  String get e164 => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagePhoneModelCopyWith<MessagePhoneModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagePhoneModelCopyWith<$Res> {
  factory $MessagePhoneModelCopyWith(
          MessagePhoneModel value, $Res Function(MessagePhoneModel) then) =
      _$MessagePhoneModelCopyWithImpl<$Res>;
  $Res call({String countryCode, String isoCode, String e164, String number});
}

/// @nodoc
class _$MessagePhoneModelCopyWithImpl<$Res>
    implements $MessagePhoneModelCopyWith<$Res> {
  _$MessagePhoneModelCopyWithImpl(this._value, this._then);

  final MessagePhoneModel _value;
  // ignore: unused_field
  final $Res Function(MessagePhoneModel) _then;

  @override
  $Res call({
    Object? countryCode = freezed,
    Object? isoCode = freezed,
    Object? e164 = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      isoCode: isoCode == freezed
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      e164: e164 == freezed
          ? _value.e164
          : e164 // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessagePhoneModelCopyWith<$Res>
    implements $MessagePhoneModelCopyWith<$Res> {
  factory _$$_MessagePhoneModelCopyWith(_$_MessagePhoneModel value,
          $Res Function(_$_MessagePhoneModel) then) =
      __$$_MessagePhoneModelCopyWithImpl<$Res>;
  @override
  $Res call({String countryCode, String isoCode, String e164, String number});
}

/// @nodoc
class __$$_MessagePhoneModelCopyWithImpl<$Res>
    extends _$MessagePhoneModelCopyWithImpl<$Res>
    implements _$$_MessagePhoneModelCopyWith<$Res> {
  __$$_MessagePhoneModelCopyWithImpl(
      _$_MessagePhoneModel _value, $Res Function(_$_MessagePhoneModel) _then)
      : super(_value, (v) => _then(v as _$_MessagePhoneModel));

  @override
  _$_MessagePhoneModel get _value => super._value as _$_MessagePhoneModel;

  @override
  $Res call({
    Object? countryCode = freezed,
    Object? isoCode = freezed,
    Object? e164 = freezed,
    Object? number = freezed,
  }) {
    return _then(_$_MessagePhoneModel(
      countryCode: countryCode == freezed
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      isoCode: isoCode == freezed
          ? _value.isoCode
          : isoCode // ignore: cast_nullable_to_non_nullable
              as String,
      e164: e164 == freezed
          ? _value.e164
          : e164 // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessagePhoneModel extends _MessagePhoneModel {
  const _$_MessagePhoneModel(
      {this.countryCode = "",
      this.isoCode = "",
      this.e164 = "",
      this.number = ""})
      : super._();

  factory _$_MessagePhoneModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessagePhoneModelFromJson(json);

  @override
  @JsonKey()
  final String countryCode;
  @override
  @JsonKey()
  final String isoCode;
  @override
  @JsonKey()
  final String e164;
  @override
  @JsonKey()
  final String number;

  @override
  String toString() {
    return 'MessagePhoneModel(countryCode: $countryCode, isoCode: $isoCode, e164: $e164, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessagePhoneModel &&
            const DeepCollectionEquality()
                .equals(other.countryCode, countryCode) &&
            const DeepCollectionEquality().equals(other.isoCode, isoCode) &&
            const DeepCollectionEquality().equals(other.e164, e164) &&
            const DeepCollectionEquality().equals(other.number, number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(countryCode),
      const DeepCollectionEquality().hash(isoCode),
      const DeepCollectionEquality().hash(e164),
      const DeepCollectionEquality().hash(number));

  @JsonKey(ignore: true)
  @override
  _$$_MessagePhoneModelCopyWith<_$_MessagePhoneModel> get copyWith =>
      __$$_MessagePhoneModelCopyWithImpl<_$_MessagePhoneModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessagePhoneModelToJson(this);
  }
}

abstract class _MessagePhoneModel extends MessagePhoneModel {
  const factory _MessagePhoneModel(
      {final String countryCode,
      final String isoCode,
      final String e164,
      final String number}) = _$_MessagePhoneModel;
  const _MessagePhoneModel._() : super._();

  factory _MessagePhoneModel.fromJson(Map<String, dynamic> json) =
      _$_MessagePhoneModel.fromJson;

  @override
  String get countryCode => throw _privateConstructorUsedError;
  @override
  String get isoCode => throw _privateConstructorUsedError;
  @override
  String get e164 => throw _privateConstructorUsedError;
  @override
  String get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessagePhoneModelCopyWith<_$_MessagePhoneModel> get copyWith =>
      throw _privateConstructorUsedError;
}
