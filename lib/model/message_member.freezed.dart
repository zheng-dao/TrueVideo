// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageMemberModel _$MessageMemberModelFromJson(Map<String, dynamic> json) {
  return _MessageMemberModel.fromJson(json);
}

/// @nodoc
mixin _$MessageMemberModel {
  String get uid => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  MessagePhoneModel? get phone => throw _privateConstructorUsedError;
  String get channelUid => throw _privateConstructorUsedError;
  int get unreadMessages => throw _privateConstructorUsedError;
  bool get pinned => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  MessageModel? get lastMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageMemberModelCopyWith<MessageMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageMemberModelCopyWith<$Res> {
  factory $MessageMemberModelCopyWith(
          MessageMemberModel value, $Res Function(MessageMemberModel) then) =
      _$MessageMemberModelCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String displayName,
      MessagePhoneModel? phone,
      String channelUid,
      int unreadMessages,
      bool pinned,
      bool enabled,
      bool visible,
      MessageModel? lastMessage});

  $MessagePhoneModelCopyWith<$Res>? get phone;
  $MessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$MessageMemberModelCopyWithImpl<$Res>
    implements $MessageMemberModelCopyWith<$Res> {
  _$MessageMemberModelCopyWithImpl(this._value, this._then);

  final MessageMemberModel _value;
  // ignore: unused_field
  final $Res Function(MessageMemberModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? phone = freezed,
    Object? channelUid = freezed,
    Object? unreadMessages = freezed,
    Object? pinned = freezed,
    Object? enabled = freezed,
    Object? visible = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as MessagePhoneModel?,
      channelUid: channelUid == freezed
          ? _value.channelUid
          : channelUid // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMessages: unreadMessages == freezed
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int,
      pinned: pinned == freezed
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: visible == freezed
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
    ));
  }

  @override
  $MessagePhoneModelCopyWith<$Res>? get phone {
    if (_value.phone == null) {
      return null;
    }

    return $MessagePhoneModelCopyWith<$Res>(_value.phone!, (value) {
      return _then(_value.copyWith(phone: value));
    });
  }

  @override
  $MessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageMemberModelCopyWith<$Res>
    implements $MessageMemberModelCopyWith<$Res> {
  factory _$$_MessageMemberModelCopyWith(_$_MessageMemberModel value,
          $Res Function(_$_MessageMemberModel) then) =
      __$$_MessageMemberModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String displayName,
      MessagePhoneModel? phone,
      String channelUid,
      int unreadMessages,
      bool pinned,
      bool enabled,
      bool visible,
      MessageModel? lastMessage});

  @override
  $MessagePhoneModelCopyWith<$Res>? get phone;
  @override
  $MessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_MessageMemberModelCopyWithImpl<$Res>
    extends _$MessageMemberModelCopyWithImpl<$Res>
    implements _$$_MessageMemberModelCopyWith<$Res> {
  __$$_MessageMemberModelCopyWithImpl(
      _$_MessageMemberModel _value, $Res Function(_$_MessageMemberModel) _then)
      : super(_value, (v) => _then(v as _$_MessageMemberModel));

  @override
  _$_MessageMemberModel get _value => super._value as _$_MessageMemberModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? phone = freezed,
    Object? channelUid = freezed,
    Object? unreadMessages = freezed,
    Object? pinned = freezed,
    Object? enabled = freezed,
    Object? visible = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(_$_MessageMemberModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as MessagePhoneModel?,
      channelUid: channelUid == freezed
          ? _value.channelUid
          : channelUid // ignore: cast_nullable_to_non_nullable
              as String,
      unreadMessages: unreadMessages == freezed
          ? _value.unreadMessages
          : unreadMessages // ignore: cast_nullable_to_non_nullable
              as int,
      pinned: pinned == freezed
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      visible: visible == freezed
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as MessageModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageMemberModel extends _MessageMemberModel {
  const _$_MessageMemberModel(
      {this.uid = "",
      this.displayName = "",
      this.phone,
      this.channelUid = "",
      this.unreadMessages = 0,
      this.pinned = false,
      this.enabled = false,
      this.visible = false,
      this.lastMessage})
      : super._();

  factory _$_MessageMemberModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageMemberModelFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String displayName;
  @override
  final MessagePhoneModel? phone;
  @override
  @JsonKey()
  final String channelUid;
  @override
  @JsonKey()
  final int unreadMessages;
  @override
  @JsonKey()
  final bool pinned;
  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool visible;
  @override
  final MessageModel? lastMessage;

  @override
  String toString() {
    return 'MessageMemberModel(uid: $uid, displayName: $displayName, phone: $phone, channelUid: $channelUid, unreadMessages: $unreadMessages, pinned: $pinned, enabled: $enabled, visible: $visible, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageMemberModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality()
                .equals(other.channelUid, channelUid) &&
            const DeepCollectionEquality()
                .equals(other.unreadMessages, unreadMessages) &&
            const DeepCollectionEquality().equals(other.pinned, pinned) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.visible, visible) &&
            const DeepCollectionEquality()
                .equals(other.lastMessage, lastMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(channelUid),
      const DeepCollectionEquality().hash(unreadMessages),
      const DeepCollectionEquality().hash(pinned),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(visible),
      const DeepCollectionEquality().hash(lastMessage));

  @JsonKey(ignore: true)
  @override
  _$$_MessageMemberModelCopyWith<_$_MessageMemberModel> get copyWith =>
      __$$_MessageMemberModelCopyWithImpl<_$_MessageMemberModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageMemberModelToJson(this);
  }
}

abstract class _MessageMemberModel extends MessageMemberModel {
  const factory _MessageMemberModel(
      {final String uid,
      final String displayName,
      final MessagePhoneModel? phone,
      final String channelUid,
      final int unreadMessages,
      final bool pinned,
      final bool enabled,
      final bool visible,
      final MessageModel? lastMessage}) = _$_MessageMemberModel;
  const _MessageMemberModel._() : super._();

  factory _MessageMemberModel.fromJson(Map<String, dynamic> json) =
      _$_MessageMemberModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  MessagePhoneModel? get phone => throw _privateConstructorUsedError;
  @override
  String get channelUid => throw _privateConstructorUsedError;
  @override
  int get unreadMessages => throw _privateConstructorUsedError;
  @override
  bool get pinned => throw _privateConstructorUsedError;
  @override
  bool get enabled => throw _privateConstructorUsedError;
  @override
  bool get visible => throw _privateConstructorUsedError;
  @override
  MessageModel? get lastMessage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageMemberModelCopyWith<_$_MessageMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}
