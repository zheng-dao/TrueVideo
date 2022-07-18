// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dealer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DealerModel _$DealerModelFromJson(Map<String, dynamic> json) {
  return _DealerModel.fromJson(json);
}

/// @nodoc
mixin _$DealerModel {
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealerModelCopyWith<DealerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealerModelCopyWith<$Res> {
  factory $DealerModelCopyWith(
          DealerModel value, $Res Function(DealerModel) then) =
      _$DealerModelCopyWithImpl<$Res>;
  $Res call({String name, String phone});
}

/// @nodoc
class _$DealerModelCopyWithImpl<$Res> implements $DealerModelCopyWith<$Res> {
  _$DealerModelCopyWithImpl(this._value, this._then);

  final DealerModel _value;
  // ignore: unused_field
  final $Res Function(DealerModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DealerModelCopyWith<$Res>
    implements $DealerModelCopyWith<$Res> {
  factory _$$_DealerModelCopyWith(
          _$_DealerModel value, $Res Function(_$_DealerModel) then) =
      __$$_DealerModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, String phone});
}

/// @nodoc
class __$$_DealerModelCopyWithImpl<$Res> extends _$DealerModelCopyWithImpl<$Res>
    implements _$$_DealerModelCopyWith<$Res> {
  __$$_DealerModelCopyWithImpl(
      _$_DealerModel _value, $Res Function(_$_DealerModel) _then)
      : super(_value, (v) => _then(v as _$_DealerModel));

  @override
  _$_DealerModel get _value => super._value as _$_DealerModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(_$_DealerModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DealerModel extends _DealerModel {
  const _$_DealerModel({this.name = "", this.phone = ""}) : super._();

  factory _$_DealerModel.fromJson(Map<String, dynamic> json) =>
      _$$_DealerModelFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phone;

  @override
  String toString() {
    return 'DealerModel(name: $name, phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DealerModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.phone, phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(phone));

  @JsonKey(ignore: true)
  @override
  _$$_DealerModelCopyWith<_$_DealerModel> get copyWith =>
      __$$_DealerModelCopyWithImpl<_$_DealerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DealerModelToJson(this);
  }
}

abstract class _DealerModel extends DealerModel {
  const factory _DealerModel({final String name, final String phone}) =
      _$_DealerModel;
  const _DealerModel._() : super._();

  factory _DealerModel.fromJson(Map<String, dynamic> json) =
      _$_DealerModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get phone => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DealerModelCopyWith<_$_DealerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
