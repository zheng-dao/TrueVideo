// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reply_item_values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReplyItemValues _$ReplyItemValuesFromJson(Map<String, dynamic> json) {
  return _ReplyItemValues.fromJson(json);
}

/// @nodoc
mixin _$ReplyItemValues {
  String get optionGroupUID => throw _privateConstructorUsedError;
  String get optionUID => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyItemValuesCopyWith<ReplyItemValues> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyItemValuesCopyWith<$Res> {
  factory $ReplyItemValuesCopyWith(
          ReplyItemValues value, $Res Function(ReplyItemValues) then) =
      _$ReplyItemValuesCopyWithImpl<$Res>;
  $Res call({String optionGroupUID, String optionUID, String? value});
}

/// @nodoc
class _$ReplyItemValuesCopyWithImpl<$Res>
    implements $ReplyItemValuesCopyWith<$Res> {
  _$ReplyItemValuesCopyWithImpl(this._value, this._then);

  final ReplyItemValues _value;
  // ignore: unused_field
  final $Res Function(ReplyItemValues) _then;

  @override
  $Res call({
    Object? optionGroupUID = freezed,
    Object? optionUID = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      optionGroupUID: optionGroupUID == freezed
          ? _value.optionGroupUID
          : optionGroupUID // ignore: cast_nullable_to_non_nullable
              as String,
      optionUID: optionUID == freezed
          ? _value.optionUID
          : optionUID // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReplyItemValuesCopyWith<$Res>
    implements $ReplyItemValuesCopyWith<$Res> {
  factory _$$_ReplyItemValuesCopyWith(
          _$_ReplyItemValues value, $Res Function(_$_ReplyItemValues) then) =
      __$$_ReplyItemValuesCopyWithImpl<$Res>;
  @override
  $Res call({String optionGroupUID, String optionUID, String? value});
}

/// @nodoc
class __$$_ReplyItemValuesCopyWithImpl<$Res>
    extends _$ReplyItemValuesCopyWithImpl<$Res>
    implements _$$_ReplyItemValuesCopyWith<$Res> {
  __$$_ReplyItemValuesCopyWithImpl(
      _$_ReplyItemValues _value, $Res Function(_$_ReplyItemValues) _then)
      : super(_value, (v) => _then(v as _$_ReplyItemValues));

  @override
  _$_ReplyItemValues get _value => super._value as _$_ReplyItemValues;

  @override
  $Res call({
    Object? optionGroupUID = freezed,
    Object? optionUID = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_ReplyItemValues(
      optionGroupUID: optionGroupUID == freezed
          ? _value.optionGroupUID
          : optionGroupUID // ignore: cast_nullable_to_non_nullable
              as String,
      optionUID: optionUID == freezed
          ? _value.optionUID
          : optionUID // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ReplyItemValues extends _ReplyItemValues {
  const _$_ReplyItemValues(
      {required this.optionGroupUID, this.optionUID = "", this.value})
      : super._();

  factory _$_ReplyItemValues.fromJson(Map<String, dynamic> json) =>
      _$$_ReplyItemValuesFromJson(json);

  @override
  final String optionGroupUID;
  @override
  @JsonKey()
  final String optionUID;
  @override
  final String? value;

  @override
  String toString() {
    return 'ReplyItemValues(optionGroupUID: $optionGroupUID, optionUID: $optionUID, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReplyItemValues &&
            const DeepCollectionEquality()
                .equals(other.optionGroupUID, optionGroupUID) &&
            const DeepCollectionEquality().equals(other.optionUID, optionUID) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(optionGroupUID),
      const DeepCollectionEquality().hash(optionUID),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_ReplyItemValuesCopyWith<_$_ReplyItemValues> get copyWith =>
      __$$_ReplyItemValuesCopyWithImpl<_$_ReplyItemValues>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReplyItemValuesToJson(this);
  }
}

abstract class _ReplyItemValues extends ReplyItemValues {
  const factory _ReplyItemValues(
      {required final String optionGroupUID,
      final String optionUID,
      final String? value}) = _$_ReplyItemValues;
  const _ReplyItemValues._() : super._();

  factory _ReplyItemValues.fromJson(Map<String, dynamic> json) =
      _$_ReplyItemValues.fromJson;

  @override
  String get optionGroupUID => throw _privateConstructorUsedError;
  @override
  String get optionUID => throw _privateConstructorUsedError;
  @override
  String? get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReplyItemValuesCopyWith<_$_ReplyItemValues> get copyWith =>
      throw _privateConstructorUsedError;
}
