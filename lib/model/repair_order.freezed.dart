// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repair_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepairOrderModel _$RepairOrderModelFromJson(Map<String, dynamic> json) {
  return _RepairOrderModel.fromJson(json);
}

/// @nodoc
mixin _$RepairOrderModel {
  int get id => throw _privateConstructorUsedError;
  String get jobServiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get createDate => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  OrderStatusModel? get orderStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepairOrderModelCopyWith<RepairOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepairOrderModelCopyWith<$Res> {
  factory $RepairOrderModelCopyWith(
          RepairOrderModel value, $Res Function(RepairOrderModel) then) =
      _$RepairOrderModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String jobServiceNumber,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? createDate,
      CustomerModel? customer,
      OrderStatusModel? orderStatus});

  $CustomerModelCopyWith<$Res>? get customer;
  $OrderStatusModelCopyWith<$Res>? get orderStatus;
}

/// @nodoc
class _$RepairOrderModelCopyWithImpl<$Res>
    implements $RepairOrderModelCopyWith<$Res> {
  _$RepairOrderModelCopyWithImpl(this._value, this._then);

  final RepairOrderModel _value;
  // ignore: unused_field
  final $Res Function(RepairOrderModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? jobServiceNumber = freezed,
    Object? createDate = freezed,
    Object? customer = freezed,
    Object? orderStatus = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jobServiceNumber: jobServiceNumber == freezed
          ? _value.jobServiceNumber
          : jobServiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderStatus: orderStatus == freezed
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatusModel?,
    ));
  }

  @override
  $CustomerModelCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerModelCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value));
    });
  }

  @override
  $OrderStatusModelCopyWith<$Res>? get orderStatus {
    if (_value.orderStatus == null) {
      return null;
    }

    return $OrderStatusModelCopyWith<$Res>(_value.orderStatus!, (value) {
      return _then(_value.copyWith(orderStatus: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepairOrderModelCopyWith<$Res>
    implements $RepairOrderModelCopyWith<$Res> {
  factory _$$_RepairOrderModelCopyWith(
          _$_RepairOrderModel value, $Res Function(_$_RepairOrderModel) then) =
      __$$_RepairOrderModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String jobServiceNumber,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? createDate,
      CustomerModel? customer,
      OrderStatusModel? orderStatus});

  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $OrderStatusModelCopyWith<$Res>? get orderStatus;
}

/// @nodoc
class __$$_RepairOrderModelCopyWithImpl<$Res>
    extends _$RepairOrderModelCopyWithImpl<$Res>
    implements _$$_RepairOrderModelCopyWith<$Res> {
  __$$_RepairOrderModelCopyWithImpl(
      _$_RepairOrderModel _value, $Res Function(_$_RepairOrderModel) _then)
      : super(_value, (v) => _then(v as _$_RepairOrderModel));

  @override
  _$_RepairOrderModel get _value => super._value as _$_RepairOrderModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? jobServiceNumber = freezed,
    Object? createDate = freezed,
    Object? customer = freezed,
    Object? orderStatus = freezed,
  }) {
    return _then(_$_RepairOrderModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jobServiceNumber: jobServiceNumber == freezed
          ? _value.jobServiceNumber
          : jobServiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderStatus: orderStatus == freezed
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatusModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RepairOrderModel extends _RepairOrderModel {
  const _$_RepairOrderModel(
      {this.id = 0,
      this.jobServiceNumber = "",
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          this.createDate,
      this.customer,
      this.orderStatus})
      : super._();

  factory _$_RepairOrderModel.fromJson(Map<String, dynamic> json) =>
      _$$_RepairOrderModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String jobServiceNumber;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  final DateTime? createDate;
  @override
  final CustomerModel? customer;
  @override
  final OrderStatusModel? orderStatus;

  @override
  String toString() {
    return 'RepairOrderModel(id: $id, jobServiceNumber: $jobServiceNumber, createDate: $createDate, customer: $customer, orderStatus: $orderStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepairOrderModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.jobServiceNumber, jobServiceNumber) &&
            const DeepCollectionEquality()
                .equals(other.createDate, createDate) &&
            const DeepCollectionEquality().equals(other.customer, customer) &&
            const DeepCollectionEquality()
                .equals(other.orderStatus, orderStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(jobServiceNumber),
      const DeepCollectionEquality().hash(createDate),
      const DeepCollectionEquality().hash(customer),
      const DeepCollectionEquality().hash(orderStatus));

  @JsonKey(ignore: true)
  @override
  _$$_RepairOrderModelCopyWith<_$_RepairOrderModel> get copyWith =>
      __$$_RepairOrderModelCopyWithImpl<_$_RepairOrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepairOrderModelToJson(this);
  }
}

abstract class _RepairOrderModel extends RepairOrderModel {
  const factory _RepairOrderModel(
      {final int id,
      final String jobServiceNumber,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          final DateTime? createDate,
      final CustomerModel? customer,
      final OrderStatusModel? orderStatus}) = _$_RepairOrderModel;
  const _RepairOrderModel._() : super._();

  factory _RepairOrderModel.fromJson(Map<String, dynamic> json) =
      _$_RepairOrderModel.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get jobServiceNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get createDate => throw _privateConstructorUsedError;
  @override
  CustomerModel? get customer => throw _privateConstructorUsedError;
  @override
  OrderStatusModel? get orderStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepairOrderModelCopyWith<_$_RepairOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
