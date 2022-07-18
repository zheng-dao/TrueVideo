// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageChannelModel _$MessageChannelModelFromJson(Map<String, dynamic> json) {
  return _MessageChannelModel.fromJson(json);
}

/// @nodoc
mixin _$MessageChannelModel {
  List<MessageMemberModel> get members => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get accountUID => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageChannelModelCopyWith<MessageChannelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageChannelModelCopyWith<$Res> {
  factory $MessageChannelModelCopyWith(
          MessageChannelModel value, $Res Function(MessageChannelModel) then) =
      _$MessageChannelModelCopyWithImpl<$Res>;
  $Res call(
      {List<MessageMemberModel> members,
      String uid,
      String displayName,
      String entityType,
      String type,
      String accountUID,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});
}

/// @nodoc
class _$MessageChannelModelCopyWithImpl<$Res>
    implements $MessageChannelModelCopyWith<$Res> {
  _$MessageChannelModelCopyWithImpl(this._value, this._then);

  final MessageChannelModel _value;
  // ignore: unused_field
  final $Res Function(MessageChannelModel) _then;

  @override
  $Res call({
    Object? members = freezed,
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? entityType = freezed,
    Object? type = freezed,
    Object? accountUID = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      members: members == freezed
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<MessageMemberModel>,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_MessageChannelModelCopyWith<$Res>
    implements $MessageChannelModelCopyWith<$Res> {
  factory _$$_MessageChannelModelCopyWith(_$_MessageChannelModel value,
          $Res Function(_$_MessageChannelModel) then) =
      __$$_MessageChannelModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<MessageMemberModel> members,
      String uid,
      String displayName,
      String entityType,
      String type,
      String accountUID,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});
}

/// @nodoc
class __$$_MessageChannelModelCopyWithImpl<$Res>
    extends _$MessageChannelModelCopyWithImpl<$Res>
    implements _$$_MessageChannelModelCopyWith<$Res> {
  __$$_MessageChannelModelCopyWithImpl(_$_MessageChannelModel _value,
      $Res Function(_$_MessageChannelModel) _then)
      : super(_value, (v) => _then(v as _$_MessageChannelModel));

  @override
  _$_MessageChannelModel get _value => super._value as _$_MessageChannelModel;

  @override
  $Res call({
    Object? members = freezed,
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? entityType = freezed,
    Object? type = freezed,
    Object? accountUID = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_MessageChannelModel(
      members: members == freezed
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<MessageMemberModel>,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_MessageChannelModel extends _MessageChannelModel {
  const _$_MessageChannelModel(
      {final List<MessageMemberModel> members = const <MessageMemberModel>[],
      this.uid = "",
      this.displayName = "",
      this.entityType = "",
      this.type = "",
      this.accountUID = "",
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          this.createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          this.updatedAt})
      : _members = members,
        super._();

  factory _$_MessageChannelModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageChannelModelFromJson(json);

  final List<MessageMemberModel> _members;
  @override
  @JsonKey()
  List<MessageMemberModel> get members {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String entityType;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String accountUID;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MessageChannelModel(members: $members, uid: $uid, displayName: $displayName, entityType: $entityType, type: $type, accountUID: $accountUID, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageChannelModel &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality()
                .equals(other.entityType, entityType) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.accountUID, accountUID) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(entityType),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(accountUID),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_MessageChannelModelCopyWith<_$_MessageChannelModel> get copyWith =>
      __$$_MessageChannelModelCopyWithImpl<_$_MessageChannelModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageChannelModelToJson(this);
  }
}

abstract class _MessageChannelModel extends MessageChannelModel {
  const factory _MessageChannelModel(
      {final List<MessageMemberModel> members,
      final String uid,
      final String displayName,
      final String entityType,
      final String type,
      final String accountUID,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? updatedAt}) = _$_MessageChannelModel;
  const _MessageChannelModel._() : super._();

  factory _MessageChannelModel.fromJson(Map<String, dynamic> json) =
      _$_MessageChannelModel.fromJson;

  @override
  List<MessageMemberModel> get members => throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  String get entityType => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get accountUID => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageChannelModelCopyWith<_$_MessageChannelModel> get copyWith =>
      throw _privateConstructorUsedError;
}
