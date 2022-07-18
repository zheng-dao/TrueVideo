// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'offline_enqueue_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OfflineEnqueueItemModel _$OfflineEnqueueItemModelFromJson(
    Map<String, dynamic> json) {
  return _OfflineEnqueueItemModel.fromJson(json);
}

/// @nodoc
mixin _$OfflineEnqueueItemModel {
  String get uid => throw _privateConstructorUsedError;
  int get typeIndex => throw _privateConstructorUsedError;
  int get statusIndex => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  Map<String, dynamic>? get result => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  int get maxRetryCount => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get startAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get endAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineEnqueueItemModelCopyWith<OfflineEnqueueItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineEnqueueItemModelCopyWith<$Res> {
  factory $OfflineEnqueueItemModelCopyWith(OfflineEnqueueItemModel value,
          $Res Function(OfflineEnqueueItemModel) then) =
      _$OfflineEnqueueItemModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      int typeIndex,
      int statusIndex,
      Map<String, dynamic>? data,
      Map<String, dynamic>? result,
      int retryCount,
      int maxRetryCount,
      String errorMessage,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? startAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? endAt});
}

/// @nodoc
class _$OfflineEnqueueItemModelCopyWithImpl<$Res>
    implements $OfflineEnqueueItemModelCopyWith<$Res> {
  _$OfflineEnqueueItemModelCopyWithImpl(this._value, this._then);

  final OfflineEnqueueItemModel _value;
  // ignore: unused_field
  final $Res Function(OfflineEnqueueItemModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? typeIndex = freezed,
    Object? statusIndex = freezed,
    Object? data = freezed,
    Object? result = freezed,
    Object? retryCount = freezed,
    Object? maxRetryCount = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      typeIndex: typeIndex == freezed
          ? _value.typeIndex
          : typeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      statusIndex: statusIndex == freezed
          ? _value.statusIndex
          : statusIndex // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      retryCount: retryCount == freezed
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetryCount: maxRetryCount == freezed
          ? _value.maxRetryCount
          : maxRetryCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endAt: endAt == freezed
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_OfflineEnqueueItemModelCopyWith<$Res>
    implements $OfflineEnqueueItemModelCopyWith<$Res> {
  factory _$$_OfflineEnqueueItemModelCopyWith(_$_OfflineEnqueueItemModel value,
          $Res Function(_$_OfflineEnqueueItemModel) then) =
      __$$_OfflineEnqueueItemModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      int typeIndex,
      int statusIndex,
      Map<String, dynamic>? data,
      Map<String, dynamic>? result,
      int retryCount,
      int maxRetryCount,
      String errorMessage,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? createdAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? updatedAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? startAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) DateTime? endAt});
}

/// @nodoc
class __$$_OfflineEnqueueItemModelCopyWithImpl<$Res>
    extends _$OfflineEnqueueItemModelCopyWithImpl<$Res>
    implements _$$_OfflineEnqueueItemModelCopyWith<$Res> {
  __$$_OfflineEnqueueItemModelCopyWithImpl(_$_OfflineEnqueueItemModel _value,
      $Res Function(_$_OfflineEnqueueItemModel) _then)
      : super(_value, (v) => _then(v as _$_OfflineEnqueueItemModel));

  @override
  _$_OfflineEnqueueItemModel get _value =>
      super._value as _$_OfflineEnqueueItemModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? typeIndex = freezed,
    Object? statusIndex = freezed,
    Object? data = freezed,
    Object? result = freezed,
    Object? retryCount = freezed,
    Object? maxRetryCount = freezed,
    Object? errorMessage = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startAt = freezed,
    Object? endAt = freezed,
  }) {
    return _then(_$_OfflineEnqueueItemModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      typeIndex: typeIndex == freezed
          ? _value.typeIndex
          : typeIndex // ignore: cast_nullable_to_non_nullable
              as int,
      statusIndex: statusIndex == freezed
          ? _value.statusIndex
          : statusIndex // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      result: result == freezed
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      retryCount: retryCount == freezed
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetryCount: maxRetryCount == freezed
          ? _value.maxRetryCount
          : maxRetryCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startAt: startAt == freezed
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endAt: endAt == freezed
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OfflineEnqueueItemModel extends _OfflineEnqueueItemModel {
  const _$_OfflineEnqueueItemModel(
      {this.uid = "",
      this.typeIndex = 0,
      this.statusIndex = 0,
      final Map<String, dynamic>? data,
      final Map<String, dynamic>? result,
      this.retryCount = 0,
      this.maxRetryCount = 0,
      this.errorMessage = "",
      @JsonKey(fromJson: DateTimeConverter.fromJson) this.createdAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) this.updatedAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) this.startAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson) this.endAt})
      : _data = data,
        _result = result,
        super._();

  factory _$_OfflineEnqueueItemModel.fromJson(Map<String, dynamic> json) =>
      _$$_OfflineEnqueueItemModelFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final int typeIndex;
  @override
  @JsonKey()
  final int statusIndex;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _result;
  @override
  Map<String, dynamic>? get result {
    final value = _result;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final int maxRetryCount;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  final DateTime? updatedAt;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  final DateTime? startAt;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  final DateTime? endAt;

  @override
  String toString() {
    return 'OfflineEnqueueItemModel(uid: $uid, typeIndex: $typeIndex, statusIndex: $statusIndex, data: $data, result: $result, retryCount: $retryCount, maxRetryCount: $maxRetryCount, errorMessage: $errorMessage, createdAt: $createdAt, updatedAt: $updatedAt, startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfflineEnqueueItemModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.typeIndex, typeIndex) &&
            const DeepCollectionEquality()
                .equals(other.statusIndex, statusIndex) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._result, _result) &&
            const DeepCollectionEquality()
                .equals(other.retryCount, retryCount) &&
            const DeepCollectionEquality()
                .equals(other.maxRetryCount, maxRetryCount) &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality().equals(other.startAt, startAt) &&
            const DeepCollectionEquality().equals(other.endAt, endAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(typeIndex),
      const DeepCollectionEquality().hash(statusIndex),
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_result),
      const DeepCollectionEquality().hash(retryCount),
      const DeepCollectionEquality().hash(maxRetryCount),
      const DeepCollectionEquality().hash(errorMessage),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(startAt),
      const DeepCollectionEquality().hash(endAt));

  @JsonKey(ignore: true)
  @override
  _$$_OfflineEnqueueItemModelCopyWith<_$_OfflineEnqueueItemModel>
      get copyWith =>
          __$$_OfflineEnqueueItemModelCopyWithImpl<_$_OfflineEnqueueItemModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfflineEnqueueItemModelToJson(this);
  }
}

abstract class _OfflineEnqueueItemModel extends OfflineEnqueueItemModel {
  const factory _OfflineEnqueueItemModel(
      {final String uid,
      final int typeIndex,
      final int statusIndex,
      final Map<String, dynamic>? data,
      final Map<String, dynamic>? result,
      final int retryCount,
      final int maxRetryCount,
      final String errorMessage,
      @JsonKey(fromJson: DateTimeConverter.fromJson)
          final DateTime? createdAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson)
          final DateTime? updatedAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson)
          final DateTime? startAt,
      @JsonKey(fromJson: DateTimeConverter.fromJson)
          final DateTime? endAt}) = _$_OfflineEnqueueItemModel;
  const _OfflineEnqueueItemModel._() : super._();

  factory _OfflineEnqueueItemModel.fromJson(Map<String, dynamic> json) =
      _$_OfflineEnqueueItemModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  int get typeIndex => throw _privateConstructorUsedError;
  @override
  int get statusIndex => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic>? get result => throw _privateConstructorUsedError;
  @override
  int get retryCount => throw _privateConstructorUsedError;
  @override
  int get maxRetryCount => throw _privateConstructorUsedError;
  @override
  String get errorMessage => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get startAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: DateTimeConverter.fromJson)
  DateTime? get endAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OfflineEnqueueItemModelCopyWith<_$_OfflineEnqueueItemModel>
      get copyWith => throw _privateConstructorUsedError;
}
