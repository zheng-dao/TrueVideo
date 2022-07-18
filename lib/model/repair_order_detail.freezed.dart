// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repair_order_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepairOrderDetailModel _$RepairOrderDetailModelFromJson(
    Map<String, dynamic> json) {
  return _RepairOrderDetailModel.fromJson(json);
}

/// @nodoc
mixin _$RepairOrderDetailModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get createDate => throw _privateConstructorUsedError;
  String get jobServiceNumber => throw _privateConstructorUsedError;
  DealerModel? get dealer => throw _privateConstructorUsedError;
  TCEUserModel? get owner => throw _privateConstructorUsedError;
  TCEUserModel? get technician => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  OrderStatusModel? get orderStatus => throw _privateConstructorUsedError;
  RepairOrderVehicleModel? get vehicle => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isForReview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepairOrderDetailModelCopyWith<RepairOrderDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepairOrderDetailModelCopyWith<$Res> {
  factory $RepairOrderDetailModelCopyWith(RepairOrderDetailModel value,
          $Res Function(RepairOrderDetailModel) then) =
      _$RepairOrderDetailModelCopyWithImpl<$Res>;
  $Res call(
      {int id,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? createDate,
      String jobServiceNumber,
      DealerModel? dealer,
      TCEUserModel? owner,
      TCEUserModel? technician,
      CustomerModel? customer,
      OrderStatusModel? orderStatus,
      RepairOrderVehicleModel? vehicle,
      String type,
      bool isForReview});

  $DealerModelCopyWith<$Res>? get dealer;
  $TCEUserModelCopyWith<$Res>? get owner;
  $TCEUserModelCopyWith<$Res>? get technician;
  $CustomerModelCopyWith<$Res>? get customer;
  $OrderStatusModelCopyWith<$Res>? get orderStatus;
  $RepairOrderVehicleModelCopyWith<$Res>? get vehicle;
}

/// @nodoc
class _$RepairOrderDetailModelCopyWithImpl<$Res>
    implements $RepairOrderDetailModelCopyWith<$Res> {
  _$RepairOrderDetailModelCopyWithImpl(this._value, this._then);

  final RepairOrderDetailModel _value;
  // ignore: unused_field
  final $Res Function(RepairOrderDetailModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = freezed,
    Object? jobServiceNumber = freezed,
    Object? dealer = freezed,
    Object? owner = freezed,
    Object? technician = freezed,
    Object? customer = freezed,
    Object? orderStatus = freezed,
    Object? vehicle = freezed,
    Object? type = freezed,
    Object? isForReview = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jobServiceNumber: jobServiceNumber == freezed
          ? _value.jobServiceNumber
          : jobServiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as DealerModel?,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
      technician: technician == freezed
          ? _value.technician
          : technician // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderStatus: orderStatus == freezed
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatusModel?,
      vehicle: vehicle == freezed
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as RepairOrderVehicleModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isForReview: isForReview == freezed
          ? _value.isForReview
          : isForReview // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $DealerModelCopyWith<$Res>? get dealer {
    if (_value.dealer == null) {
      return null;
    }

    return $DealerModelCopyWith<$Res>(_value.dealer!, (value) {
      return _then(_value.copyWith(dealer: value));
    });
  }

  @override
  $TCEUserModelCopyWith<$Res>? get owner {
    if (_value.owner == null) {
      return null;
    }

    return $TCEUserModelCopyWith<$Res>(_value.owner!, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }

  @override
  $TCEUserModelCopyWith<$Res>? get technician {
    if (_value.technician == null) {
      return null;
    }

    return $TCEUserModelCopyWith<$Res>(_value.technician!, (value) {
      return _then(_value.copyWith(technician: value));
    });
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

  @override
  $RepairOrderVehicleModelCopyWith<$Res>? get vehicle {
    if (_value.vehicle == null) {
      return null;
    }

    return $RepairOrderVehicleModelCopyWith<$Res>(_value.vehicle!, (value) {
      return _then(_value.copyWith(vehicle: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepairOrderDetailModelCopyWith<$Res>
    implements $RepairOrderDetailModelCopyWith<$Res> {
  factory _$$_RepairOrderDetailModelCopyWith(_$_RepairOrderDetailModel value,
          $Res Function(_$_RepairOrderDetailModel) then) =
      __$$_RepairOrderDetailModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? createDate,
      String jobServiceNumber,
      DealerModel? dealer,
      TCEUserModel? owner,
      TCEUserModel? technician,
      CustomerModel? customer,
      OrderStatusModel? orderStatus,
      RepairOrderVehicleModel? vehicle,
      String type,
      bool isForReview});

  @override
  $DealerModelCopyWith<$Res>? get dealer;
  @override
  $TCEUserModelCopyWith<$Res>? get owner;
  @override
  $TCEUserModelCopyWith<$Res>? get technician;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $OrderStatusModelCopyWith<$Res>? get orderStatus;
  @override
  $RepairOrderVehicleModelCopyWith<$Res>? get vehicle;
}

/// @nodoc
class __$$_RepairOrderDetailModelCopyWithImpl<$Res>
    extends _$RepairOrderDetailModelCopyWithImpl<$Res>
    implements _$$_RepairOrderDetailModelCopyWith<$Res> {
  __$$_RepairOrderDetailModelCopyWithImpl(_$_RepairOrderDetailModel _value,
      $Res Function(_$_RepairOrderDetailModel) _then)
      : super(_value, (v) => _then(v as _$_RepairOrderDetailModel));

  @override
  _$_RepairOrderDetailModel get _value =>
      super._value as _$_RepairOrderDetailModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? createDate = freezed,
    Object? jobServiceNumber = freezed,
    Object? dealer = freezed,
    Object? owner = freezed,
    Object? technician = freezed,
    Object? customer = freezed,
    Object? orderStatus = freezed,
    Object? vehicle = freezed,
    Object? type = freezed,
    Object? isForReview = freezed,
  }) {
    return _then(_$_RepairOrderDetailModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createDate: createDate == freezed
          ? _value.createDate
          : createDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      jobServiceNumber: jobServiceNumber == freezed
          ? _value.jobServiceNumber
          : jobServiceNumber // ignore: cast_nullable_to_non_nullable
              as String,
      dealer: dealer == freezed
          ? _value.dealer
          : dealer // ignore: cast_nullable_to_non_nullable
              as DealerModel?,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
      technician: technician == freezed
          ? _value.technician
          : technician // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      orderStatus: orderStatus == freezed
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatusModel?,
      vehicle: vehicle == freezed
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as RepairOrderVehicleModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isForReview: isForReview == freezed
          ? _value.isForReview
          : isForReview // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RepairOrderDetailModel extends _RepairOrderDetailModel {
  const _$_RepairOrderDetailModel(
      {this.id = 0,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          this.createDate,
      this.jobServiceNumber = "",
      this.dealer,
      this.owner,
      this.technician,
      this.customer,
      this.orderStatus,
      this.vehicle,
      this.type = "",
      this.isForReview = false})
      : super._();

  factory _$_RepairOrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_RepairOrderDetailModelFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  final DateTime? createDate;
  @override
  @JsonKey()
  final String jobServiceNumber;
  @override
  final DealerModel? dealer;
  @override
  final TCEUserModel? owner;
  @override
  final TCEUserModel? technician;
  @override
  final CustomerModel? customer;
  @override
  final OrderStatusModel? orderStatus;
  @override
  final RepairOrderVehicleModel? vehicle;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final bool isForReview;

  @override
  String toString() {
    return 'RepairOrderDetailModel(id: $id, createDate: $createDate, jobServiceNumber: $jobServiceNumber, dealer: $dealer, owner: $owner, technician: $technician, customer: $customer, orderStatus: $orderStatus, vehicle: $vehicle, type: $type, isForReview: $isForReview)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepairOrderDetailModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.createDate, createDate) &&
            const DeepCollectionEquality()
                .equals(other.jobServiceNumber, jobServiceNumber) &&
            const DeepCollectionEquality().equals(other.dealer, dealer) &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality()
                .equals(other.technician, technician) &&
            const DeepCollectionEquality().equals(other.customer, customer) &&
            const DeepCollectionEquality()
                .equals(other.orderStatus, orderStatus) &&
            const DeepCollectionEquality().equals(other.vehicle, vehicle) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.isForReview, isForReview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(createDate),
      const DeepCollectionEquality().hash(jobServiceNumber),
      const DeepCollectionEquality().hash(dealer),
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(technician),
      const DeepCollectionEquality().hash(customer),
      const DeepCollectionEquality().hash(orderStatus),
      const DeepCollectionEquality().hash(vehicle),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(isForReview));

  @JsonKey(ignore: true)
  @override
  _$$_RepairOrderDetailModelCopyWith<_$_RepairOrderDetailModel> get copyWith =>
      __$$_RepairOrderDetailModelCopyWithImpl<_$_RepairOrderDetailModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepairOrderDetailModelToJson(this);
  }
}

abstract class _RepairOrderDetailModel extends RepairOrderDetailModel {
  const factory _RepairOrderDetailModel(
      {final int id,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          final DateTime? createDate,
      final String jobServiceNumber,
      final DealerModel? dealer,
      final TCEUserModel? owner,
      final TCEUserModel? technician,
      final CustomerModel? customer,
      final OrderStatusModel? orderStatus,
      final RepairOrderVehicleModel? vehicle,
      final String type,
      final bool isForReview}) = _$_RepairOrderDetailModel;
  const _RepairOrderDetailModel._() : super._();

  factory _RepairOrderDetailModel.fromJson(Map<String, dynamic> json) =
      _$_RepairOrderDetailModel.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get createDate => throw _privateConstructorUsedError;
  @override
  String get jobServiceNumber => throw _privateConstructorUsedError;
  @override
  DealerModel? get dealer => throw _privateConstructorUsedError;
  @override
  TCEUserModel? get owner => throw _privateConstructorUsedError;
  @override
  TCEUserModel? get technician => throw _privateConstructorUsedError;
  @override
  CustomerModel? get customer => throw _privateConstructorUsedError;
  @override
  OrderStatusModel? get orderStatus => throw _privateConstructorUsedError;
  @override
  RepairOrderVehicleModel? get vehicle => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  bool get isForReview => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepairOrderDetailModelCopyWith<_$_RepairOrderDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
