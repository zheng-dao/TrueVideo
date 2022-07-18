// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_list_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageListItemModel _$MessageListItemModelFromJson(Map<String, dynamic> json) {
  return _MessageListItemModel.fromJson(json);
}

/// @nodoc
mixin _$MessageListItemModel {
  String get offlineEnqueueUid => throw _privateConstructorUsedError;
  OfflineEnqueueItemStatus get offlineEnqueueStatus =>
      throw _privateConstructorUsedError;
  bool get isFromOfflineEnqueue => throw _privateConstructorUsedError;
  MessageModel? get model => throw _privateConstructorUsedError;
  MessageListItemType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageListItemModelCopyWith<MessageListItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageListItemModelCopyWith<$Res> {
  factory $MessageListItemModelCopyWith(MessageListItemModel value,
          $Res Function(MessageListItemModel) then) =
      _$MessageListItemModelCopyWithImpl<$Res>;
  $Res call(
      {String offlineEnqueueUid,
      OfflineEnqueueItemStatus offlineEnqueueStatus,
      bool isFromOfflineEnqueue,
      MessageModel? model,
      MessageListItemType type,
      String title});

  $MessageModelCopyWith<$Res>? get model;
}

/// @nodoc
class _$MessageListItemModelCopyWithImpl<$Res>
    implements $MessageListItemModelCopyWith<$Res> {
  _$MessageListItemModelCopyWithImpl(this._value, this._then);

  final MessageListItemModel _value;
  // ignore: unused_field
  final $Res Function(MessageListItemModel) _then;

  @override
  $Res call({
    Object? offlineEnqueueUid = freezed,
    Object? offlineEnqueueStatus = freezed,
    Object? isFromOfflineEnqueue = freezed,
    Object? model = freezed,
    Object? type = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      offlineEnqueueUid: offlineEnqueueUid == freezed
          ? _value.offlineEnqueueUid
          : offlineEnqueueUid // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueStatus: offlineEnqueueStatus == freezed
          ? _value.offlineEnqueueStatus
          : offlineEnqueueStatus // ignore: cast_nullable_to_non_nullable
              as OfflineEnqueueItemStatus,
      isFromOfflineEnqueue: isFromOfflineEnqueue == freezed
          ? _value.isFromOfflineEnqueue
          : isFromOfflineEnqueue // ignore: cast_nullable_to_non_nullable
              as bool,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageListItemType,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $MessageModelCopyWith<$Res>? get model {
    if (_value.model == null) {
      return null;
    }

    return $MessageModelCopyWith<$Res>(_value.model!, (value) {
      return _then(_value.copyWith(model: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageListItemModelCopyWith<$Res>
    implements $MessageListItemModelCopyWith<$Res> {
  factory _$$_MessageListItemModelCopyWith(_$_MessageListItemModel value,
          $Res Function(_$_MessageListItemModel) then) =
      __$$_MessageListItemModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String offlineEnqueueUid,
      OfflineEnqueueItemStatus offlineEnqueueStatus,
      bool isFromOfflineEnqueue,
      MessageModel? model,
      MessageListItemType type,
      String title});

  @override
  $MessageModelCopyWith<$Res>? get model;
}

/// @nodoc
class __$$_MessageListItemModelCopyWithImpl<$Res>
    extends _$MessageListItemModelCopyWithImpl<$Res>
    implements _$$_MessageListItemModelCopyWith<$Res> {
  __$$_MessageListItemModelCopyWithImpl(_$_MessageListItemModel _value,
      $Res Function(_$_MessageListItemModel) _then)
      : super(_value, (v) => _then(v as _$_MessageListItemModel));

  @override
  _$_MessageListItemModel get _value => super._value as _$_MessageListItemModel;

  @override
  $Res call({
    Object? offlineEnqueueUid = freezed,
    Object? offlineEnqueueStatus = freezed,
    Object? isFromOfflineEnqueue = freezed,
    Object? model = freezed,
    Object? type = freezed,
    Object? title = freezed,
  }) {
    return _then(_$_MessageListItemModel(
      offlineEnqueueUid: offlineEnqueueUid == freezed
          ? _value.offlineEnqueueUid
          : offlineEnqueueUid // ignore: cast_nullable_to_non_nullable
              as String,
      offlineEnqueueStatus: offlineEnqueueStatus == freezed
          ? _value.offlineEnqueueStatus
          : offlineEnqueueStatus // ignore: cast_nullable_to_non_nullable
              as OfflineEnqueueItemStatus,
      isFromOfflineEnqueue: isFromOfflineEnqueue == freezed
          ? _value.isFromOfflineEnqueue
          : isFromOfflineEnqueue // ignore: cast_nullable_to_non_nullable
              as bool,
      model: model == freezed
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageListItemType,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageListItemModel extends _MessageListItemModel {
  const _$_MessageListItemModel(
      {this.offlineEnqueueUid = "",
      this.offlineEnqueueStatus = OfflineEnqueueItemStatus.pending,
      this.isFromOfflineEnqueue = false,
      this.model,
      this.type = MessageListItemType.first,
      this.title = ""})
      : super._();

  factory _$_MessageListItemModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageListItemModelFromJson(json);

  @override
  @JsonKey()
  final String offlineEnqueueUid;
  @override
  @JsonKey()
  final OfflineEnqueueItemStatus offlineEnqueueStatus;
  @override
  @JsonKey()
  final bool isFromOfflineEnqueue;
  @override
  final MessageModel? model;
  @override
  @JsonKey()
  final MessageListItemType type;
  @override
  @JsonKey()
  final String title;

  @override
  String toString() {
    return 'MessageListItemModel(offlineEnqueueUid: $offlineEnqueueUid, offlineEnqueueStatus: $offlineEnqueueStatus, isFromOfflineEnqueue: $isFromOfflineEnqueue, model: $model, type: $type, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageListItemModel &&
            const DeepCollectionEquality()
                .equals(other.offlineEnqueueUid, offlineEnqueueUid) &&
            const DeepCollectionEquality()
                .equals(other.offlineEnqueueStatus, offlineEnqueueStatus) &&
            const DeepCollectionEquality()
                .equals(other.isFromOfflineEnqueue, isFromOfflineEnqueue) &&
            const DeepCollectionEquality().equals(other.model, model) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(offlineEnqueueUid),
      const DeepCollectionEquality().hash(offlineEnqueueStatus),
      const DeepCollectionEquality().hash(isFromOfflineEnqueue),
      const DeepCollectionEquality().hash(model),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$$_MessageListItemModelCopyWith<_$_MessageListItemModel> get copyWith =>
      __$$_MessageListItemModelCopyWithImpl<_$_MessageListItemModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageListItemModelToJson(this);
  }
}

abstract class _MessageListItemModel extends MessageListItemModel {
  const factory _MessageListItemModel(
      {final String offlineEnqueueUid,
      final OfflineEnqueueItemStatus offlineEnqueueStatus,
      final bool isFromOfflineEnqueue,
      final MessageModel? model,
      final MessageListItemType type,
      final String title}) = _$_MessageListItemModel;
  const _MessageListItemModel._() : super._();

  factory _MessageListItemModel.fromJson(Map<String, dynamic> json) =
      _$_MessageListItemModel.fromJson;

  @override
  String get offlineEnqueueUid => throw _privateConstructorUsedError;
  @override
  OfflineEnqueueItemStatus get offlineEnqueueStatus =>
      throw _privateConstructorUsedError;
  @override
  bool get isFromOfflineEnqueue => throw _privateConstructorUsedError;
  @override
  MessageModel? get model => throw _privateConstructorUsedError;
  @override
  MessageListItemType get type => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageListItemModelCopyWith<_$_MessageListItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}
