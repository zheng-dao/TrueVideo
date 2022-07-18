// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_call_participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageCallParticipantModel _$MessageCallParticipantModelFromJson(
    Map<String, dynamic> json) {
  return _MessageCallParticipantModel.fromJson(json);
}

/// @nodoc
mixin _$MessageCallParticipantModel {
  String get callSid => throw _privateConstructorUsedError;
  String get conferenceSid => throw _privateConstructorUsedError;
  String get messageableEntityUID => throw _privateConstructorUsedError;
  String get messageableEntityDisplayName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  bool get hold => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCallParticipantModelCopyWith<MessageCallParticipantModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCallParticipantModelCopyWith<$Res> {
  factory $MessageCallParticipantModelCopyWith(
          MessageCallParticipantModel value,
          $Res Function(MessageCallParticipantModel) then) =
      _$MessageCallParticipantModelCopyWithImpl<$Res>;
  $Res call(
      {String callSid,
      String conferenceSid,
      String messageableEntityUID,
      String messageableEntityDisplayName,
      String status,
      bool hold,
      bool muted,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt});
}

/// @nodoc
class _$MessageCallParticipantModelCopyWithImpl<$Res>
    implements $MessageCallParticipantModelCopyWith<$Res> {
  _$MessageCallParticipantModelCopyWithImpl(this._value, this._then);

  final MessageCallParticipantModel _value;
  // ignore: unused_field
  final $Res Function(MessageCallParticipantModel) _then;

  @override
  $Res call({
    Object? callSid = freezed,
    Object? conferenceSid = freezed,
    Object? messageableEntityUID = freezed,
    Object? messageableEntityDisplayName = freezed,
    Object? status = freezed,
    Object? hold = freezed,
    Object? muted = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      callSid: callSid == freezed
          ? _value.callSid
          : callSid // ignore: cast_nullable_to_non_nullable
              as String,
      conferenceSid: conferenceSid == freezed
          ? _value.conferenceSid
          : conferenceSid // ignore: cast_nullable_to_non_nullable
              as String,
      messageableEntityUID: messageableEntityUID == freezed
          ? _value.messageableEntityUID
          : messageableEntityUID // ignore: cast_nullable_to_non_nullable
              as String,
      messageableEntityDisplayName: messageableEntityDisplayName == freezed
          ? _value.messageableEntityDisplayName
          : messageableEntityDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hold: hold == freezed
          ? _value.hold
          : hold // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageCallParticipantModelCopyWith<$Res>
    implements $MessageCallParticipantModelCopyWith<$Res> {
  factory _$$_MessageCallParticipantModelCopyWith(
          _$_MessageCallParticipantModel value,
          $Res Function(_$_MessageCallParticipantModel) then) =
      __$$_MessageCallParticipantModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String callSid,
      String conferenceSid,
      String messageableEntityUID,
      String messageableEntityDisplayName,
      String status,
      bool hold,
      bool muted,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt});
}

/// @nodoc
class __$$_MessageCallParticipantModelCopyWithImpl<$Res>
    extends _$MessageCallParticipantModelCopyWithImpl<$Res>
    implements _$$_MessageCallParticipantModelCopyWith<$Res> {
  __$$_MessageCallParticipantModelCopyWithImpl(
      _$_MessageCallParticipantModel _value,
      $Res Function(_$_MessageCallParticipantModel) _then)
      : super(_value, (v) => _then(v as _$_MessageCallParticipantModel));

  @override
  _$_MessageCallParticipantModel get _value =>
      super._value as _$_MessageCallParticipantModel;

  @override
  $Res call({
    Object? callSid = freezed,
    Object? conferenceSid = freezed,
    Object? messageableEntityUID = freezed,
    Object? messageableEntityDisplayName = freezed,
    Object? status = freezed,
    Object? hold = freezed,
    Object? muted = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_MessageCallParticipantModel(
      callSid: callSid == freezed
          ? _value.callSid
          : callSid // ignore: cast_nullable_to_non_nullable
              as String,
      conferenceSid: conferenceSid == freezed
          ? _value.conferenceSid
          : conferenceSid // ignore: cast_nullable_to_non_nullable
              as String,
      messageableEntityUID: messageableEntityUID == freezed
          ? _value.messageableEntityUID
          : messageableEntityUID // ignore: cast_nullable_to_non_nullable
              as String,
      messageableEntityDisplayName: messageableEntityDisplayName == freezed
          ? _value.messageableEntityDisplayName
          : messageableEntityDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hold: hold == freezed
          ? _value.hold
          : hold // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageCallParticipantModel extends _MessageCallParticipantModel {
  const _$_MessageCallParticipantModel(
      {this.callSid = "",
      this.conferenceSid = "",
      this.messageableEntityUID = "",
      this.messageableEntityDisplayName = "",
      this.status = "",
      this.hold = false,
      this.muted = false,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          this.createdAt})
      : super._();

  factory _$_MessageCallParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageCallParticipantModelFromJson(json);

  @override
  @JsonKey()
  final String callSid;
  @override
  @JsonKey()
  final String conferenceSid;
  @override
  @JsonKey()
  final String messageableEntityUID;
  @override
  @JsonKey()
  final String messageableEntityDisplayName;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool hold;
  @override
  @JsonKey()
  final bool muted;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MessageCallParticipantModel(callSid: $callSid, conferenceSid: $conferenceSid, messageableEntityUID: $messageableEntityUID, messageableEntityDisplayName: $messageableEntityDisplayName, status: $status, hold: $hold, muted: $muted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageCallParticipantModel &&
            const DeepCollectionEquality().equals(other.callSid, callSid) &&
            const DeepCollectionEquality()
                .equals(other.conferenceSid, conferenceSid) &&
            const DeepCollectionEquality()
                .equals(other.messageableEntityUID, messageableEntityUID) &&
            const DeepCollectionEquality().equals(
                other.messageableEntityDisplayName,
                messageableEntityDisplayName) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.hold, hold) &&
            const DeepCollectionEquality().equals(other.muted, muted) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(callSid),
      const DeepCollectionEquality().hash(conferenceSid),
      const DeepCollectionEquality().hash(messageableEntityUID),
      const DeepCollectionEquality().hash(messageableEntityDisplayName),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(hold),
      const DeepCollectionEquality().hash(muted),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_MessageCallParticipantModelCopyWith<_$_MessageCallParticipantModel>
      get copyWith => __$$_MessageCallParticipantModelCopyWithImpl<
          _$_MessageCallParticipantModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageCallParticipantModelToJson(this);
  }
}

abstract class _MessageCallParticipantModel
    extends MessageCallParticipantModel {
  const factory _MessageCallParticipantModel(
      {final String callSid,
      final String conferenceSid,
      final String messageableEntityUID,
      final String messageableEntityDisplayName,
      final String status,
      final bool hold,
      final bool muted,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? createdAt}) = _$_MessageCallParticipantModel;
  const _MessageCallParticipantModel._() : super._();

  factory _MessageCallParticipantModel.fromJson(Map<String, dynamic> json) =
      _$_MessageCallParticipantModel.fromJson;

  @override
  String get callSid => throw _privateConstructorUsedError;
  @override
  String get conferenceSid => throw _privateConstructorUsedError;
  @override
  String get messageableEntityUID => throw _privateConstructorUsedError;
  @override
  String get messageableEntityDisplayName => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  bool get hold => throw _privateConstructorUsedError;
  @override
  bool get muted => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCallParticipantModelCopyWith<_$_MessageCallParticipantModel>
      get copyWith => throw _privateConstructorUsedError;
}
