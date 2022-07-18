// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dealer_code_access_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DealerCodeAccessHistoryModel _$DealerCodeAccessHistoryModelFromJson(
    Map<String, dynamic> json) {
  return _DealerCodeAccessHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$DealerCodeAccessHistoryModel {
  DateTime? get date => throw _privateConstructorUsedError;
  String get dealerCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DealerCodeAccessHistoryModelCopyWith<DealerCodeAccessHistoryModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DealerCodeAccessHistoryModelCopyWith<$Res> {
  factory $DealerCodeAccessHistoryModelCopyWith(
          DealerCodeAccessHistoryModel value,
          $Res Function(DealerCodeAccessHistoryModel) then) =
      _$DealerCodeAccessHistoryModelCopyWithImpl<$Res>;
  $Res call({DateTime? date, String dealerCode});
}

/// @nodoc
class _$DealerCodeAccessHistoryModelCopyWithImpl<$Res>
    implements $DealerCodeAccessHistoryModelCopyWith<$Res> {
  _$DealerCodeAccessHistoryModelCopyWithImpl(this._value, this._then);

  final DealerCodeAccessHistoryModel _value;
  // ignore: unused_field
  final $Res Function(DealerCodeAccessHistoryModel) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? dealerCode = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dealerCode: dealerCode == freezed
          ? _value.dealerCode
          : dealerCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DealerCodeAccessHistoryModelCopyWith<$Res>
    implements $DealerCodeAccessHistoryModelCopyWith<$Res> {
  factory _$$_DealerCodeAccessHistoryModelCopyWith(
          _$_DealerCodeAccessHistoryModel value,
          $Res Function(_$_DealerCodeAccessHistoryModel) then) =
      __$$_DealerCodeAccessHistoryModelCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? date, String dealerCode});
}

/// @nodoc
class __$$_DealerCodeAccessHistoryModelCopyWithImpl<$Res>
    extends _$DealerCodeAccessHistoryModelCopyWithImpl<$Res>
    implements _$$_DealerCodeAccessHistoryModelCopyWith<$Res> {
  __$$_DealerCodeAccessHistoryModelCopyWithImpl(
      _$_DealerCodeAccessHistoryModel _value,
      $Res Function(_$_DealerCodeAccessHistoryModel) _then)
      : super(_value, (v) => _then(v as _$_DealerCodeAccessHistoryModel));

  @override
  _$_DealerCodeAccessHistoryModel get _value =>
      super._value as _$_DealerCodeAccessHistoryModel;

  @override
  $Res call({
    Object? date = freezed,
    Object? dealerCode = freezed,
  }) {
    return _then(_$_DealerCodeAccessHistoryModel(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dealerCode: dealerCode == freezed
          ? _value.dealerCode
          : dealerCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DealerCodeAccessHistoryModel extends _DealerCodeAccessHistoryModel {
  const _$_DealerCodeAccessHistoryModel({this.date, this.dealerCode = ""})
      : super._();

  factory _$_DealerCodeAccessHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$$_DealerCodeAccessHistoryModelFromJson(json);

  @override
  final DateTime? date;
  @override
  @JsonKey()
  final String dealerCode;

  @override
  String toString() {
    return 'DealerCodeAccessHistoryModel(date: $date, dealerCode: $dealerCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DealerCodeAccessHistoryModel &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.dealerCode, dealerCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(dealerCode));

  @JsonKey(ignore: true)
  @override
  _$$_DealerCodeAccessHistoryModelCopyWith<_$_DealerCodeAccessHistoryModel>
      get copyWith => __$$_DealerCodeAccessHistoryModelCopyWithImpl<
          _$_DealerCodeAccessHistoryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DealerCodeAccessHistoryModelToJson(this);
  }
}

abstract class _DealerCodeAccessHistoryModel
    extends DealerCodeAccessHistoryModel {
  const factory _DealerCodeAccessHistoryModel(
      {final DateTime? date,
      final String dealerCode}) = _$_DealerCodeAccessHistoryModel;
  const _DealerCodeAccessHistoryModel._() : super._();

  factory _DealerCodeAccessHistoryModel.fromJson(Map<String, dynamic> json) =
      _$_DealerCodeAccessHistoryModel.fromJson;

  @override
  DateTime? get date => throw _privateConstructorUsedError;
  @override
  String get dealerCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DealerCodeAccessHistoryModelCopyWith<_$_DealerCodeAccessHistoryModel>
      get copyWith => throw _privateConstructorUsedError;
}
