// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dealer_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DealerInfoModel _$DealerInfoModelFromJson(Map<String, dynamic> json) {
  return _DealerInfoModel.fromJson(json);
}

/// @nodoc
mixin _$DealerInfoModel {
  String get publicDealerUuid => throw _privateConstructorUsedError;
  String get dealerCodeType => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealerInfoModelCopyWith<DealerInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealerInfoModelCopyWith<$Res> {
  factory $DealerInfoModelCopyWith(
          DealerInfoModel value, $Res Function(DealerInfoModel) then) =
      _$DealerInfoModelCopyWithImpl<$Res>;
  $Res call({String publicDealerUuid, String dealerCodeType, String name});
}

/// @nodoc
class _$DealerInfoModelCopyWithImpl<$Res>
    implements $DealerInfoModelCopyWith<$Res> {
  _$DealerInfoModelCopyWithImpl(this._value, this._then);

  final DealerInfoModel _value;
  // ignore: unused_field
  final $Res Function(DealerInfoModel) _then;

  @override
  $Res call({
    Object? publicDealerUuid = freezed,
    Object? dealerCodeType = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      publicDealerUuid: publicDealerUuid == freezed
          ? _value.publicDealerUuid
          : publicDealerUuid // ignore: cast_nullable_to_non_nullable
              as String,
      dealerCodeType: dealerCodeType == freezed
          ? _value.dealerCodeType
          : dealerCodeType // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DealerInfoModelCopyWith<$Res>
    implements $DealerInfoModelCopyWith<$Res> {
  factory _$$_DealerInfoModelCopyWith(
          _$_DealerInfoModel value, $Res Function(_$_DealerInfoModel) then) =
      __$$_DealerInfoModelCopyWithImpl<$Res>;
  @override
  $Res call({String publicDealerUuid, String dealerCodeType, String name});
}

/// @nodoc
class __$$_DealerInfoModelCopyWithImpl<$Res>
    extends _$DealerInfoModelCopyWithImpl<$Res>
    implements _$$_DealerInfoModelCopyWith<$Res> {
  __$$_DealerInfoModelCopyWithImpl(
      _$_DealerInfoModel _value, $Res Function(_$_DealerInfoModel) _then)
      : super(_value, (v) => _then(v as _$_DealerInfoModel));

  @override
  _$_DealerInfoModel get _value => super._value as _$_DealerInfoModel;

  @override
  $Res call({
    Object? publicDealerUuid = freezed,
    Object? dealerCodeType = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_DealerInfoModel(
      publicDealerUuid: publicDealerUuid == freezed
          ? _value.publicDealerUuid
          : publicDealerUuid // ignore: cast_nullable_to_non_nullable
              as String,
      dealerCodeType: dealerCodeType == freezed
          ? _value.dealerCodeType
          : dealerCodeType // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DealerInfoModel extends _DealerInfoModel {
  const _$_DealerInfoModel(
      {this.publicDealerUuid = "", this.dealerCodeType = "", this.name = ""})
      : super._();

  factory _$_DealerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_DealerInfoModelFromJson(json);

  @override
  @JsonKey()
  final String publicDealerUuid;
  @override
  @JsonKey()
  final String dealerCodeType;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'DealerInfoModel(publicDealerUuid: $publicDealerUuid, dealerCodeType: $dealerCodeType, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DealerInfoModel &&
            const DeepCollectionEquality()
                .equals(other.publicDealerUuid, publicDealerUuid) &&
            const DeepCollectionEquality()
                .equals(other.dealerCodeType, dealerCodeType) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(publicDealerUuid),
      const DeepCollectionEquality().hash(dealerCodeType),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_DealerInfoModelCopyWith<_$_DealerInfoModel> get copyWith =>
      __$$_DealerInfoModelCopyWithImpl<_$_DealerInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DealerInfoModelToJson(this);
  }
}

abstract class _DealerInfoModel extends DealerInfoModel {
  const factory _DealerInfoModel(
      {final String publicDealerUuid,
      final String dealerCodeType,
      final String name}) = _$_DealerInfoModel;
  const _DealerInfoModel._() : super._();

  factory _DealerInfoModel.fromJson(Map<String, dynamic> json) =
      _$_DealerInfoModel.fromJson;

  @override
  String get publicDealerUuid => throw _privateConstructorUsedError;
  @override
  String get dealerCodeType => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DealerInfoModelCopyWith<_$_DealerInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
