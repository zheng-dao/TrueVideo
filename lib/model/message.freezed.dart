// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  String get uid => throw _privateConstructorUsedError;
  String get auxUID => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String get applicationUID => throw _privateConstructorUsedError;
  String get channelUID => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get accountUID => throw _privateConstructorUsedError;
  MessageUserModel? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String auxUID,
      String body,
      String source,
      String type,
      String entityType,
      String applicationUID,
      String channelUID,
      String imageURL,
      String displayName,
      String status,
      String accountUID,
      MessageUserModel? createdBy,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});

  $MessageUserModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res> implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  final MessageModel _value;
  // ignore: unused_field
  final $Res Function(MessageModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? auxUID = freezed,
    Object? body = freezed,
    Object? source = freezed,
    Object? type = freezed,
    Object? entityType = freezed,
    Object? applicationUID = freezed,
    Object? channelUID = freezed,
    Object? imageURL = freezed,
    Object? displayName = freezed,
    Object? status = freezed,
    Object? accountUID = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      auxUID: auxUID == freezed
          ? _value.auxUID
          : auxUID // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      applicationUID: applicationUID == freezed
          ? _value.applicationUID
          : applicationUID // ignore: cast_nullable_to_non_nullable
              as String,
      channelUID: channelUID == freezed
          ? _value.channelUID
          : channelUID // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as MessageUserModel?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $MessageUserModelCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $MessageUserModelCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageModelCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$_MessageModelCopyWith(
          _$_MessageModel value, $Res Function(_$_MessageModel) then) =
      __$$_MessageModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String auxUID,
      String body,
      String source,
      String type,
      String entityType,
      String applicationUID,
      String channelUID,
      String imageURL,
      String displayName,
      String status,
      String accountUID,
      MessageUserModel? createdBy,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});

  @override
  $MessageUserModelCopyWith<$Res>? get createdBy;
}

/// @nodoc
class __$$_MessageModelCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res>
    implements _$$_MessageModelCopyWith<$Res> {
  __$$_MessageModelCopyWithImpl(
      _$_MessageModel _value, $Res Function(_$_MessageModel) _then)
      : super(_value, (v) => _then(v as _$_MessageModel));

  @override
  _$_MessageModel get _value => super._value as _$_MessageModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? auxUID = freezed,
    Object? body = freezed,
    Object? source = freezed,
    Object? type = freezed,
    Object? entityType = freezed,
    Object? applicationUID = freezed,
    Object? channelUID = freezed,
    Object? imageURL = freezed,
    Object? displayName = freezed,
    Object? status = freezed,
    Object? accountUID = freezed,
    Object? createdBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_MessageModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      auxUID: auxUID == freezed
          ? _value.auxUID
          : auxUID // ignore: cast_nullable_to_non_nullable
              as String,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      applicationUID: applicationUID == freezed
          ? _value.applicationUID
          : applicationUID // ignore: cast_nullable_to_non_nullable
              as String,
      channelUID: channelUID == freezed
          ? _value.channelUID
          : channelUID // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: createdBy == freezed
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as MessageUserModel?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageModel extends _MessageModel {
  const _$_MessageModel(
      {this.uid = "",
      this.auxUID = "",
      this.body = "",
      this.source = "",
      this.type = "",
      this.entityType = "",
      this.applicationUID = "",
      this.channelUID = "",
      this.imageURL = "",
      this.displayName = "",
      this.status = "",
      this.accountUID = "",
      this.createdBy,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          this.createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          this.updatedAt})
      : super._();

  factory _$_MessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageModelFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String auxUID;
  @override
  @JsonKey()
  final String body;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String entityType;
  @override
  @JsonKey()
  final String applicationUID;
  @override
  @JsonKey()
  final String channelUID;
  @override
  @JsonKey()
  final String imageURL;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String accountUID;
  @override
  final MessageUserModel? createdBy;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MessageModel(uid: $uid, auxUID: $auxUID, body: $body, source: $source, type: $type, entityType: $entityType, applicationUID: $applicationUID, channelUID: $channelUID, imageURL: $imageURL, displayName: $displayName, status: $status, accountUID: $accountUID, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.auxUID, auxUID) &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.entityType, entityType) &&
            const DeepCollectionEquality()
                .equals(other.applicationUID, applicationUID) &&
            const DeepCollectionEquality()
                .equals(other.channelUID, channelUID) &&
            const DeepCollectionEquality().equals(other.imageURL, imageURL) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.accountUID, accountUID) &&
            const DeepCollectionEquality().equals(other.createdBy, createdBy) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(auxUID),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(entityType),
      const DeepCollectionEquality().hash(applicationUID),
      const DeepCollectionEquality().hash(channelUID),
      const DeepCollectionEquality().hash(imageURL),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(accountUID),
      const DeepCollectionEquality().hash(createdBy),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      __$$_MessageModelCopyWithImpl<_$_MessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageModelToJson(this);
  }
}

abstract class _MessageModel extends MessageModel {
  const factory _MessageModel(
      {final String uid,
      final String auxUID,
      final String body,
      final String source,
      final String type,
      final String entityType,
      final String applicationUID,
      final String channelUID,
      final String imageURL,
      final String displayName,
      final String status,
      final String accountUID,
      final MessageUserModel? createdBy,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? updatedAt}) = _$_MessageModel;
  const _MessageModel._() : super._();

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$_MessageModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get auxUID => throw _privateConstructorUsedError;
  @override
  String get body => throw _privateConstructorUsedError;
  @override
  String get source => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get entityType => throw _privateConstructorUsedError;
  @override
  String get applicationUID => throw _privateConstructorUsedError;
  @override
  String get channelUID => throw _privateConstructorUsedError;
  @override
  String get imageURL => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  String get accountUID => throw _privateConstructorUsedError;
  @override
  MessageUserModel? get createdBy => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageModelCopyWith<_$_MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
