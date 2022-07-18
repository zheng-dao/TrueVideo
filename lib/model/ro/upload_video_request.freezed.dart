// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'upload_video_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepairOrderUploadVideoRequestModel _$RepairOrderUploadVideoRequestModelFromJson(
    Map<String, dynamic> json) {
  return _RepairOrderUploadVideoRequestModel.fromJson(json);
}

/// @nodoc
mixin _$RepairOrderUploadVideoRequestModel {
  String get uid => throw _privateConstructorUsedError;
  String get offlineEnqueueUID => throw _privateConstructorUsedError;
  OfflineEnqueueItemStatus? get offlineEnqueueStatus =>
      throw _privateConstructorUsedError;
  int get orderID => throw _privateConstructorUsedError;
  String get orderType => throw _privateConstructorUsedError;
  CameraResultModel? get cameraResult => throw _privateConstructorUsedError;
  @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get creationDate => throw _privateConstructorUsedError;
  @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get updateDate => throw _privateConstructorUsedError;
  String get videoTagID => throw _privateConstructorUsedError;
  String get videoTypeID => throw _privateConstructorUsedError;
  String get videoDescription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepairOrderUploadVideoRequestModelCopyWith<
          RepairOrderUploadVideoRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepairOrderUploadVideoRequestModelCopyWith<$Res> {
  factory $RepairOrderUploadVideoRequestModelCopyWith(
          RepairOrderUploadVideoRequestModel value,
          $Res Function(RepairOrderUploadVideoRequestModel) then) =
      _$RepairOrderUploadVideoRequestModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String offlineEnqueueUID,
      OfflineEnqueueItemStatus? offlineEnqueueStatus,
      int orderID,
      String orderType,
      CameraResultModel? cameraResult,
      @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
          DateTime? creationDate,
      @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
          DateTime? updateDate,
      String videoTagID,
      String videoTypeID,
      String videoDescription});

  $CameraResultModelCopyWith<$Res>? get cameraResult;
}

/// @nodoc
class _$RepairOrderUploadVideoRequestModelCopyWithImpl<$Res>
    implements $RepairOrderUploadVideoRequestModelCopyWith<$Res> {
  _$RepairOrderUploadVideoRequestModelCopyWithImpl(this._value, this._then);

  final RepairOrderUploadVideoRequestModel _value;
  // ignore: unused_field
  final $Res Function(RepairOrderUploadVideoRequestModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? offlineEnqueueUID = freezed,
    Object? offlineEnqueueStatus = freezed,
    Object? orderID = freezed,
    Object? orderType = freezed,
    Object? cameraResult = freezed,
    Object? creationDate = freezed,
    Object? updateDate = freezed,
    Object? videoTagID = freezed,
    Object? videoTypeID = freezed,
    Object? videoDescription = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueUID: offlineEnqueueUID == freezed
          ? _value.offlineEnqueueUID
          : offlineEnqueueUID // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueStatus: offlineEnqueueStatus == freezed
          ? _value.offlineEnqueueStatus
          : offlineEnqueueStatus // ignore: cast_nullable_to_non_nullable
              as OfflineEnqueueItemStatus?,
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: orderType == freezed
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      cameraResult: cameraResult == freezed
          ? _value.cameraResult
          : cameraResult // ignore: cast_nullable_to_non_nullable
              as CameraResultModel?,
      creationDate: creationDate == freezed
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateDate: updateDate == freezed
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      videoTagID: videoTagID == freezed
          ? _value.videoTagID
          : videoTagID // ignore: cast_nullable_to_non_nullable
              as String,
      videoTypeID: videoTypeID == freezed
          ? _value.videoTypeID
          : videoTypeID // ignore: cast_nullable_to_non_nullable
              as String,
      videoDescription: videoDescription == freezed
          ? _value.videoDescription
          : videoDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $CameraResultModelCopyWith<$Res>? get cameraResult {
    if (_value.cameraResult == null) {
      return null;
    }

    return $CameraResultModelCopyWith<$Res>(_value.cameraResult!, (value) {
      return _then(_value.copyWith(cameraResult: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepairOrderUploadVideoRequestModelCopyWith<$Res>
    implements $RepairOrderUploadVideoRequestModelCopyWith<$Res> {
  factory _$$_RepairOrderUploadVideoRequestModelCopyWith(
          _$_RepairOrderUploadVideoRequestModel value,
          $Res Function(_$_RepairOrderUploadVideoRequestModel) then) =
      __$$_RepairOrderUploadVideoRequestModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String offlineEnqueueUID,
      OfflineEnqueueItemStatus? offlineEnqueueStatus,
      int orderID,
      String orderType,
      CameraResultModel? cameraResult,
      @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
          DateTime? creationDate,
      @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
          DateTime? updateDate,
      String videoTagID,
      String videoTypeID,
      String videoDescription});

  @override
  $CameraResultModelCopyWith<$Res>? get cameraResult;
}

/// @nodoc
class __$$_RepairOrderUploadVideoRequestModelCopyWithImpl<$Res>
    extends _$RepairOrderUploadVideoRequestModelCopyWithImpl<$Res>
    implements _$$_RepairOrderUploadVideoRequestModelCopyWith<$Res> {
  __$$_RepairOrderUploadVideoRequestModelCopyWithImpl(
      _$_RepairOrderUploadVideoRequestModel _value,
      $Res Function(_$_RepairOrderUploadVideoRequestModel) _then)
      : super(_value, (v) => _then(v as _$_RepairOrderUploadVideoRequestModel));

  @override
  _$_RepairOrderUploadVideoRequestModel get _value =>
      super._value as _$_RepairOrderUploadVideoRequestModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? offlineEnqueueUID = freezed,
    Object? offlineEnqueueStatus = freezed,
    Object? orderID = freezed,
    Object? orderType = freezed,
    Object? cameraResult = freezed,
    Object? creationDate = freezed,
    Object? updateDate = freezed,
    Object? videoTagID = freezed,
    Object? videoTypeID = freezed,
    Object? videoDescription = freezed,
  }) {
    return _then(_$_RepairOrderUploadVideoRequestModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueUID: offlineEnqueueUID == freezed
          ? _value.offlineEnqueueUID
          : offlineEnqueueUID // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueStatus: offlineEnqueueStatus == freezed
          ? _value.offlineEnqueueStatus
          : offlineEnqueueStatus // ignore: cast_nullable_to_non_nullable
              as OfflineEnqueueItemStatus?,
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int,
      orderType: orderType == freezed
          ? _value.orderType
          : orderType // ignore: cast_nullable_to_non_nullable
              as String,
      cameraResult: cameraResult == freezed
          ? _value.cameraResult
          : cameraResult // ignore: cast_nullable_to_non_nullable
              as CameraResultModel?,
      creationDate: creationDate == freezed
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateDate: updateDate == freezed
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      videoTagID: videoTagID == freezed
          ? _value.videoTagID
          : videoTagID // ignore: cast_nullable_to_non_nullable
              as String,
      videoTypeID: videoTypeID == freezed
          ? _value.videoTypeID
          : videoTypeID // ignore: cast_nullable_to_non_nullable
              as String,
      videoDescription: videoDescription == freezed
          ? _value.videoDescription
          : videoDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RepairOrderUploadVideoRequestModel
    extends _RepairOrderUploadVideoRequestModel {
  const _$_RepairOrderUploadVideoRequestModel(
      {this.uid = "",
      this.offlineEnqueueUID = "",
      this.offlineEnqueueStatus,
      this.orderID = 0,
      this.orderType = "",
      this.cameraResult,
      @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
          this.creationDate,
      @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
          this.updateDate,
      this.videoTagID = "",
      this.videoTypeID = "",
      this.videoDescription = ""})
      : super._();

  factory _$_RepairOrderUploadVideoRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_RepairOrderUploadVideoRequestModelFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String offlineEnqueueUID;
  @override
  final OfflineEnqueueItemStatus? offlineEnqueueStatus;
  @override
  @JsonKey()
  final int orderID;
  @override
  @JsonKey()
  final String orderType;
  @override
  final CameraResultModel? cameraResult;
  @override
  @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
  final DateTime? creationDate;
  @override
  @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
  final DateTime? updateDate;
  @override
  @JsonKey()
  final String videoTagID;
  @override
  @JsonKey()
  final String videoTypeID;
  @override
  @JsonKey()
  final String videoDescription;

  @override
  String toString() {
    return 'RepairOrderUploadVideoRequestModel(uid: $uid, offlineEnqueueUID: $offlineEnqueueUID, offlineEnqueueStatus: $offlineEnqueueStatus, orderID: $orderID, orderType: $orderType, cameraResult: $cameraResult, creationDate: $creationDate, updateDate: $updateDate, videoTagID: $videoTagID, videoTypeID: $videoTypeID, videoDescription: $videoDescription)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepairOrderUploadVideoRequestModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.offlineEnqueueUID, offlineEnqueueUID) &&
            const DeepCollectionEquality()
                .equals(other.offlineEnqueueStatus, offlineEnqueueStatus) &&
            const DeepCollectionEquality().equals(other.orderID, orderID) &&
            const DeepCollectionEquality().equals(other.orderType, orderType) &&
            const DeepCollectionEquality()
                .equals(other.cameraResult, cameraResult) &&
            const DeepCollectionEquality()
                .equals(other.creationDate, creationDate) &&
            const DeepCollectionEquality()
                .equals(other.updateDate, updateDate) &&
            const DeepCollectionEquality()
                .equals(other.videoTagID, videoTagID) &&
            const DeepCollectionEquality()
                .equals(other.videoTypeID, videoTypeID) &&
            const DeepCollectionEquality()
                .equals(other.videoDescription, videoDescription));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(offlineEnqueueUID),
      const DeepCollectionEquality().hash(offlineEnqueueStatus),
      const DeepCollectionEquality().hash(orderID),
      const DeepCollectionEquality().hash(orderType),
      const DeepCollectionEquality().hash(cameraResult),
      const DeepCollectionEquality().hash(creationDate),
      const DeepCollectionEquality().hash(updateDate),
      const DeepCollectionEquality().hash(videoTagID),
      const DeepCollectionEquality().hash(videoTypeID),
      const DeepCollectionEquality().hash(videoDescription));

  @JsonKey(ignore: true)
  @override
  _$$_RepairOrderUploadVideoRequestModelCopyWith<
          _$_RepairOrderUploadVideoRequestModel>
      get copyWith => __$$_RepairOrderUploadVideoRequestModelCopyWithImpl<
          _$_RepairOrderUploadVideoRequestModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepairOrderUploadVideoRequestModelToJson(this);
  }
}

abstract class _RepairOrderUploadVideoRequestModel
    extends RepairOrderUploadVideoRequestModel {
  const factory _RepairOrderUploadVideoRequestModel(
      {final String uid,
      final String offlineEnqueueUID,
      final OfflineEnqueueItemStatus? offlineEnqueueStatus,
      final int orderID,
      final String orderType,
      final CameraResultModel? cameraResult,
      @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
          final DateTime? creationDate,
      @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
          final DateTime? updateDate,
      final String videoTagID,
      final String videoTypeID,
      final String videoDescription}) = _$_RepairOrderUploadVideoRequestModel;
  const _RepairOrderUploadVideoRequestModel._() : super._();

  factory _RepairOrderUploadVideoRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$_RepairOrderUploadVideoRequestModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get offlineEnqueueUID => throw _privateConstructorUsedError;
  @override
  OfflineEnqueueItemStatus? get offlineEnqueueStatus =>
      throw _privateConstructorUsedError;
  @override
  int get orderID => throw _privateConstructorUsedError;
  @override
  String get orderType => throw _privateConstructorUsedError;
  @override
  CameraResultModel? get cameraResult => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "creationDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get creationDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "updateDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get updateDate => throw _privateConstructorUsedError;
  @override
  String get videoTagID => throw _privateConstructorUsedError;
  @override
  String get videoTypeID => throw _privateConstructorUsedError;
  @override
  String get videoDescription => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepairOrderUploadVideoRequestModelCopyWith<
          _$_RepairOrderUploadVideoRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}
