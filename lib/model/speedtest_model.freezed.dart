// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'speedtest_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SpeedtestModel _$SpeedtestModelFromJson(Map<String, dynamic> json) {
  return _SpeedtestModel.fromJson(json);
}

/// @nodoc
mixin _$SpeedtestModel {
  double get transferRate => throw _privateConstructorUsedError;
  String get speedUnit => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpeedtestModelCopyWith<SpeedtestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeedtestModelCopyWith<$Res> {
  factory $SpeedtestModelCopyWith(
          SpeedtestModel value, $Res Function(SpeedtestModel) then) =
      _$SpeedtestModelCopyWithImpl<$Res>;
  $Res call({double transferRate, String speedUnit, String type});
}

/// @nodoc
class _$SpeedtestModelCopyWithImpl<$Res>
    implements $SpeedtestModelCopyWith<$Res> {
  _$SpeedtestModelCopyWithImpl(this._value, this._then);

  final SpeedtestModel _value;
  // ignore: unused_field
  final $Res Function(SpeedtestModel) _then;

  @override
  $Res call({
    Object? transferRate = freezed,
    Object? speedUnit = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      transferRate: transferRate == freezed
          ? _value.transferRate
          : transferRate // ignore: cast_nullable_to_non_nullable
              as double,
      speedUnit: speedUnit == freezed
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SpeedtestModelCopyWith<$Res>
    implements $SpeedtestModelCopyWith<$Res> {
  factory _$$_SpeedtestModelCopyWith(
          _$_SpeedtestModel value, $Res Function(_$_SpeedtestModel) then) =
      __$$_SpeedtestModelCopyWithImpl<$Res>;
  @override
  $Res call({double transferRate, String speedUnit, String type});
}

/// @nodoc
class __$$_SpeedtestModelCopyWithImpl<$Res>
    extends _$SpeedtestModelCopyWithImpl<$Res>
    implements _$$_SpeedtestModelCopyWith<$Res> {
  __$$_SpeedtestModelCopyWithImpl(
      _$_SpeedtestModel _value, $Res Function(_$_SpeedtestModel) _then)
      : super(_value, (v) => _then(v as _$_SpeedtestModel));

  @override
  _$_SpeedtestModel get _value => super._value as _$_SpeedtestModel;

  @override
  $Res call({
    Object? transferRate = freezed,
    Object? speedUnit = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_SpeedtestModel(
      transferRate: transferRate == freezed
          ? _value.transferRate
          : transferRate // ignore: cast_nullable_to_non_nullable
              as double,
      speedUnit: speedUnit == freezed
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SpeedtestModel extends _SpeedtestModel {
  _$_SpeedtestModel(
      {this.transferRate = 0, this.speedUnit = '', this.type = ''})
      : super._();

  factory _$_SpeedtestModel.fromJson(Map<String, dynamic> json) =>
      _$$_SpeedtestModelFromJson(json);

  @override
  @JsonKey()
  final double transferRate;
  @override
  @JsonKey()
  final String speedUnit;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SpeedtestModel(transferRate: $transferRate, speedUnit: $speedUnit, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpeedtestModel &&
            const DeepCollectionEquality()
                .equals(other.transferRate, transferRate) &&
            const DeepCollectionEquality().equals(other.speedUnit, speedUnit) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(transferRate),
      const DeepCollectionEquality().hash(speedUnit),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$_SpeedtestModelCopyWith<_$_SpeedtestModel> get copyWith =>
      __$$_SpeedtestModelCopyWithImpl<_$_SpeedtestModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SpeedtestModelToJson(this);
  }
}

abstract class _SpeedtestModel extends SpeedtestModel {
  factory _SpeedtestModel(
      {final double transferRate,
      final String speedUnit,
      final String type}) = _$_SpeedtestModel;
  _SpeedtestModel._() : super._();

  factory _SpeedtestModel.fromJson(Map<String, dynamic> json) =
      _$_SpeedtestModel.fromJson;

  @override
  double get transferRate => throw _privateConstructorUsedError;
  @override
  String get speedUnit => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SpeedtestModelCopyWith<_$_SpeedtestModel> get copyWith =>
      throw _privateConstructorUsedError;
}
