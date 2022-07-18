// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceInfoModel _$DeviceInfoModelFromJson(Map<String, dynamic> json) {
  return _DeviceInfoModel.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfoModel {
  String get id => throw _privateConstructorUsedError;
  String get manufacturer => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneOS => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceInfoModelCopyWith<DeviceInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoModelCopyWith<$Res> {
  factory $DeviceInfoModelCopyWith(
          DeviceInfoModel value, $Res Function(DeviceInfoModel) then) =
      _$DeviceInfoModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String manufacturer,
      String model,
      String name,
      String phoneOS});
}

/// @nodoc
class _$DeviceInfoModelCopyWithImpl<$Res>
    implements $DeviceInfoModelCopyWith<$Res> {
  _$DeviceInfoModelCopyWithImpl(this._value, this._then);

  final DeviceInfoModel _value;
  // ignore: unused_field
  final $Res Function(DeviceInfoModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? manufacturer = freezed,
    Object? model = freezed,
    Object? name = freezed,
    Object? phoneOS = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: manufacturer == freezed
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneOS: phoneOS == freezed
          ? _value.phoneOS
          : phoneOS // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DeviceInfoModelCopyWith<$Res>
    implements $DeviceInfoModelCopyWith<$Res> {
  factory _$$_DeviceInfoModelCopyWith(
          _$_DeviceInfoModel value, $Res Function(_$_DeviceInfoModel) then) =
      __$$_DeviceInfoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String manufacturer,
      String model,
      String name,
      String phoneOS});
}

/// @nodoc
class __$$_DeviceInfoModelCopyWithImpl<$Res>
    extends _$DeviceInfoModelCopyWithImpl<$Res>
    implements _$$_DeviceInfoModelCopyWith<$Res> {
  __$$_DeviceInfoModelCopyWithImpl(
      _$_DeviceInfoModel _value, $Res Function(_$_DeviceInfoModel) _then)
      : super(_value, (v) => _then(v as _$_DeviceInfoModel));

  @override
  _$_DeviceInfoModel get _value => super._value as _$_DeviceInfoModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? manufacturer = freezed,
    Object? model = freezed,
    Object? name = freezed,
    Object? phoneOS = freezed,
  }) {
    return _then(_$_DeviceInfoModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: manufacturer == freezed
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneOS: phoneOS == freezed
          ? _value.phoneOS
          : phoneOS // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DeviceInfoModel extends _DeviceInfoModel {
  const _$_DeviceInfoModel(
      {this.id = "",
      this.manufacturer = "",
      this.model = "",
      this.name = "",
      this.phoneOS = ""})
      : super._();

  factory _$_DeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceInfoModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String manufacturer;
  @override
  @JsonKey()
  final String model;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phoneOS;

  @override
  String toString() {
    return 'DeviceInfoModel(id: $id, manufacturer: $manufacturer, model: $model, name: $name, phoneOS: $phoneOS)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceInfoModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.manufacturer, manufacturer) &&
            const DeepCollectionEquality().equals(other.model, model) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.phoneOS, phoneOS));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(manufacturer),
      const DeepCollectionEquality().hash(model),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(phoneOS));

  @JsonKey(ignore: true)
  @override
  _$$_DeviceInfoModelCopyWith<_$_DeviceInfoModel> get copyWith =>
      __$$_DeviceInfoModelCopyWithImpl<_$_DeviceInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceInfoModelToJson(this);
  }
}

abstract class _DeviceInfoModel extends DeviceInfoModel {
  const factory _DeviceInfoModel(
      {final String id,
      final String manufacturer,
      final String model,
      final String name,
      final String phoneOS}) = _$_DeviceInfoModel;
  const _DeviceInfoModel._() : super._();

  factory _DeviceInfoModel.fromJson(Map<String, dynamic> json) =
      _$_DeviceInfoModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get manufacturer => throw _privateConstructorUsedError;
  @override
  String get model => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get phoneOS => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceInfoModelCopyWith<_$_DeviceInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
