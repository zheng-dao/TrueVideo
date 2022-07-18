// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'event_video_uploaded.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventVideoUploadedModel _$EventVideoUploadedModelFromJson(
    Map<String, dynamic> json) {
  return _EventVideoUploadedModel.fromJson(json);
}

/// @nodoc
mixin _$EventVideoUploadedModel {
  int get orderID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventVideoUploadedModelCopyWith<EventVideoUploadedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventVideoUploadedModelCopyWith<$Res> {
  factory $EventVideoUploadedModelCopyWith(EventVideoUploadedModel value,
          $Res Function(EventVideoUploadedModel) then) =
      _$EventVideoUploadedModelCopyWithImpl<$Res>;
  $Res call({int orderID});
}

/// @nodoc
class _$EventVideoUploadedModelCopyWithImpl<$Res>
    implements $EventVideoUploadedModelCopyWith<$Res> {
  _$EventVideoUploadedModelCopyWithImpl(this._value, this._then);

  final EventVideoUploadedModel _value;
  // ignore: unused_field
  final $Res Function(EventVideoUploadedModel) _then;

  @override
  $Res call({
    Object? orderID = freezed,
  }) {
    return _then(_value.copyWith(
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_EventVideoUploadedModelCopyWith<$Res>
    implements $EventVideoUploadedModelCopyWith<$Res> {
  factory _$$_EventVideoUploadedModelCopyWith(_$_EventVideoUploadedModel value,
          $Res Function(_$_EventVideoUploadedModel) then) =
      __$$_EventVideoUploadedModelCopyWithImpl<$Res>;
  @override
  $Res call({int orderID});
}

/// @nodoc
class __$$_EventVideoUploadedModelCopyWithImpl<$Res>
    extends _$EventVideoUploadedModelCopyWithImpl<$Res>
    implements _$$_EventVideoUploadedModelCopyWith<$Res> {
  __$$_EventVideoUploadedModelCopyWithImpl(_$_EventVideoUploadedModel _value,
      $Res Function(_$_EventVideoUploadedModel) _then)
      : super(_value, (v) => _then(v as _$_EventVideoUploadedModel));

  @override
  _$_EventVideoUploadedModel get _value =>
      super._value as _$_EventVideoUploadedModel;

  @override
  $Res call({
    Object? orderID = freezed,
  }) {
    return _then(_$_EventVideoUploadedModel(
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_EventVideoUploadedModel extends _EventVideoUploadedModel {
  const _$_EventVideoUploadedModel({this.orderID = 0}) : super._();

  factory _$_EventVideoUploadedModel.fromJson(Map<String, dynamic> json) =>
      _$$_EventVideoUploadedModelFromJson(json);

  @override
  @JsonKey()
  final int orderID;

  @override
  String toString() {
    return 'EventVideoUploadedModel(orderID: $orderID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventVideoUploadedModel &&
            const DeepCollectionEquality().equals(other.orderID, orderID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(orderID));

  @JsonKey(ignore: true)
  @override
  _$$_EventVideoUploadedModelCopyWith<_$_EventVideoUploadedModel>
      get copyWith =>
          __$$_EventVideoUploadedModelCopyWithImpl<_$_EventVideoUploadedModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventVideoUploadedModelToJson(this);
  }
}

abstract class _EventVideoUploadedModel extends EventVideoUploadedModel {
  const factory _EventVideoUploadedModel({final int orderID}) =
      _$_EventVideoUploadedModel;
  const _EventVideoUploadedModel._() : super._();

  factory _EventVideoUploadedModel.fromJson(Map<String, dynamic> json) =
      _$_EventVideoUploadedModel.fromJson;

  @override
  int get orderID => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EventVideoUploadedModelCopyWith<_$_EventVideoUploadedModel>
      get copyWith => throw _privateConstructorUsedError;
}
