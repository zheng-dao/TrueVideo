// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderStatusModel _$OrderStatusModelFromJson(Map<String, dynamic> json) {
  return _OrderStatusModel.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusModel {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusModelCopyWith<OrderStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusModelCopyWith<$Res> {
  factory $OrderStatusModelCopyWith(
          OrderStatusModel value, $Res Function(OrderStatusModel) then) =
      _$OrderStatusModelCopyWithImpl<$Res>;
  $Res call({String key, String value});
}

/// @nodoc
class _$OrderStatusModelCopyWithImpl<$Res>
    implements $OrderStatusModelCopyWith<$Res> {
  _$OrderStatusModelCopyWithImpl(this._value, this._then);

  final OrderStatusModel _value;
  // ignore: unused_field
  final $Res Function(OrderStatusModel) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_OrderStatusModelCopyWith<$Res>
    implements $OrderStatusModelCopyWith<$Res> {
  factory _$$_OrderStatusModelCopyWith(
          _$_OrderStatusModel value, $Res Function(_$_OrderStatusModel) then) =
      __$$_OrderStatusModelCopyWithImpl<$Res>;
  @override
  $Res call({String key, String value});
}

/// @nodoc
class __$$_OrderStatusModelCopyWithImpl<$Res>
    extends _$OrderStatusModelCopyWithImpl<$Res>
    implements _$$_OrderStatusModelCopyWith<$Res> {
  __$$_OrderStatusModelCopyWithImpl(
      _$_OrderStatusModel _value, $Res Function(_$_OrderStatusModel) _then)
      : super(_value, (v) => _then(v as _$_OrderStatusModel));

  @override
  _$_OrderStatusModel get _value => super._value as _$_OrderStatusModel;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_OrderStatusModel(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OrderStatusModel extends _OrderStatusModel {
  const _$_OrderStatusModel({this.key = "", this.value = ""}) : super._();

  factory _$_OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderStatusModelFromJson(json);

  @override
  @JsonKey()
  final String key;
  @override
  @JsonKey()
  final String value;

  @override
  String toString() {
    return 'OrderStatusModel(key: $key, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusModel &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_OrderStatusModelCopyWith<_$_OrderStatusModel> get copyWith =>
      __$$_OrderStatusModelCopyWithImpl<_$_OrderStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderStatusModelToJson(this);
  }
}

abstract class _OrderStatusModel extends OrderStatusModel {
  const factory _OrderStatusModel({final String key, final String value}) =
      _$_OrderStatusModel;
  const _OrderStatusModel._() : super._();

  factory _OrderStatusModel.fromJson(Map<String, dynamic> json) =
      _$_OrderStatusModel.fromJson;

  @override
  String get key => throw _privateConstructorUsedError;
  @override
  String get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusModelCopyWith<_$_OrderStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}
