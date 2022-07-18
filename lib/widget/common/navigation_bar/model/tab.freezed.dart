// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TabModel _$TabModelFromJson(Map<String, dynamic> json) {
  return _TabModel.fromJson(json);
}

/// @nodoc
mixin _$TabModel {
  int get value => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get icon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TabModelCopyWith<TabModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabModelCopyWith<$Res> {
  factory $TabModelCopyWith(TabModel value, $Res Function(TabModel) then) =
      _$TabModelCopyWithImpl<$Res>;
  $Res call({int value, String text, int icon});
}

/// @nodoc
class _$TabModelCopyWithImpl<$Res> implements $TabModelCopyWith<$Res> {
  _$TabModelCopyWithImpl(this._value, this._then);

  final TabModel _value;
  // ignore: unused_field
  final $Res Function(TabModel) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? text = freezed,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_TabModelCopyWith<$Res> implements $TabModelCopyWith<$Res> {
  factory _$$_TabModelCopyWith(
          _$_TabModel value, $Res Function(_$_TabModel) then) =
      __$$_TabModelCopyWithImpl<$Res>;
  @override
  $Res call({int value, String text, int icon});
}

/// @nodoc
class __$$_TabModelCopyWithImpl<$Res> extends _$TabModelCopyWithImpl<$Res>
    implements _$$_TabModelCopyWith<$Res> {
  __$$_TabModelCopyWithImpl(
      _$_TabModel _value, $Res Function(_$_TabModel) _then)
      : super(_value, (v) => _then(v as _$_TabModel));

  @override
  _$_TabModel get _value => super._value as _$_TabModel;

  @override
  $Res call({
    Object? value = freezed,
    Object? text = freezed,
    Object? icon = freezed,
  }) {
    return _then(_$_TabModel(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TabModel extends _TabModel {
  const _$_TabModel({this.value = 0, this.text = "", this.icon = 0})
      : super._();

  factory _$_TabModel.fromJson(Map<String, dynamic> json) =>
      _$$_TabModelFromJson(json);

  @override
  @JsonKey()
  final int value;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final int icon;

  @override
  String toString() {
    return 'TabModel(value: $value, text: $text, icon: $icon)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TabModel &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.icon, icon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(icon));

  @JsonKey(ignore: true)
  @override
  _$$_TabModelCopyWith<_$_TabModel> get copyWith =>
      __$$_TabModelCopyWithImpl<_$_TabModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TabModelToJson(this);
  }
}

abstract class _TabModel extends TabModel {
  const factory _TabModel(
      {final int value, final String text, final int icon}) = _$_TabModel;
  const _TabModel._() : super._();

  factory _TabModel.fromJson(Map<String, dynamic> json) = _$_TabModel.fromJson;

  @override
  int get value => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  int get icon => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TabModelCopyWith<_$_TabModel> get copyWith =>
      throw _privateConstructorUsedError;
}
