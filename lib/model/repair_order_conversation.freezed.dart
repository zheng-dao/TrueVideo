// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repair_order_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RepairOrderConversationModel _$RepairOrderConversationModelFromJson(
    Map<String, dynamic> json) {
  return _RepairOrderConversationModel.fromJson(json);
}

/// @nodoc
mixin _$RepairOrderConversationModel {
  List<TextMessageModel>? get messages => throw _privateConstructorUsedError;
  TextMessageModel? get lastTextMessage => throw _privateConstructorUsedError;
  CustomerModel? get customer => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  TCEUserModel? get owner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepairOrderConversationModelCopyWith<RepairOrderConversationModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepairOrderConversationModelCopyWith<$Res> {
  factory $RepairOrderConversationModelCopyWith(
          RepairOrderConversationModel value,
          $Res Function(RepairOrderConversationModel) then) =
      _$RepairOrderConversationModelCopyWithImpl<$Res>;
  $Res call(
      {List<TextMessageModel>? messages,
      TextMessageModel? lastTextMessage,
      CustomerModel? customer,
      String? status,
      TCEUserModel? owner});

  $TextMessageModelCopyWith<$Res>? get lastTextMessage;
  $CustomerModelCopyWith<$Res>? get customer;
  $TCEUserModelCopyWith<$Res>? get owner;
}

/// @nodoc
class _$RepairOrderConversationModelCopyWithImpl<$Res>
    implements $RepairOrderConversationModelCopyWith<$Res> {
  _$RepairOrderConversationModelCopyWithImpl(this._value, this._then);

  final RepairOrderConversationModel _value;
  // ignore: unused_field
  final $Res Function(RepairOrderConversationModel) _then;

  @override
  $Res call({
    Object? messages = freezed,
    Object? lastTextMessage = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? owner = freezed,
  }) {
    return _then(_value.copyWith(
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TextMessageModel>?,
      lastTextMessage: lastTextMessage == freezed
          ? _value.lastTextMessage
          : lastTextMessage // ignore: cast_nullable_to_non_nullable
              as TextMessageModel?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
    ));
  }

  @override
  $TextMessageModelCopyWith<$Res>? get lastTextMessage {
    if (_value.lastTextMessage == null) {
      return null;
    }

    return $TextMessageModelCopyWith<$Res>(_value.lastTextMessage!, (value) {
      return _then(_value.copyWith(lastTextMessage: value));
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
  $TCEUserModelCopyWith<$Res>? get owner {
    if (_value.owner == null) {
      return null;
    }

    return $TCEUserModelCopyWith<$Res>(_value.owner!, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }
}

/// @nodoc
abstract class _$$_RepairOrderConversationModelCopyWith<$Res>
    implements $RepairOrderConversationModelCopyWith<$Res> {
  factory _$$_RepairOrderConversationModelCopyWith(
          _$_RepairOrderConversationModel value,
          $Res Function(_$_RepairOrderConversationModel) then) =
      __$$_RepairOrderConversationModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<TextMessageModel>? messages,
      TextMessageModel? lastTextMessage,
      CustomerModel? customer,
      String? status,
      TCEUserModel? owner});

  @override
  $TextMessageModelCopyWith<$Res>? get lastTextMessage;
  @override
  $CustomerModelCopyWith<$Res>? get customer;
  @override
  $TCEUserModelCopyWith<$Res>? get owner;
}

/// @nodoc
class __$$_RepairOrderConversationModelCopyWithImpl<$Res>
    extends _$RepairOrderConversationModelCopyWithImpl<$Res>
    implements _$$_RepairOrderConversationModelCopyWith<$Res> {
  __$$_RepairOrderConversationModelCopyWithImpl(
      _$_RepairOrderConversationModel _value,
      $Res Function(_$_RepairOrderConversationModel) _then)
      : super(_value, (v) => _then(v as _$_RepairOrderConversationModel));

  @override
  _$_RepairOrderConversationModel get _value =>
      super._value as _$_RepairOrderConversationModel;

  @override
  $Res call({
    Object? messages = freezed,
    Object? lastTextMessage = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? owner = freezed,
  }) {
    return _then(_$_RepairOrderConversationModel(
      messages: messages == freezed
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<TextMessageModel>?,
      lastTextMessage: lastTextMessage == freezed
          ? _value.lastTextMessage
          : lastTextMessage // ignore: cast_nullable_to_non_nullable
              as TextMessageModel?,
      customer: customer == freezed
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as CustomerModel?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TCEUserModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RepairOrderConversationModel extends _RepairOrderConversationModel {
  const _$_RepairOrderConversationModel(
      {final List<TextMessageModel>? messages,
      this.lastTextMessage,
      this.customer,
      this.status,
      this.owner})
      : _messages = messages,
        super._();

  factory _$_RepairOrderConversationModel.fromJson(Map<String, dynamic> json) =>
      _$$_RepairOrderConversationModelFromJson(json);

  final List<TextMessageModel>? _messages;
  @override
  List<TextMessageModel>? get messages {
    final value = _messages;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TextMessageModel? lastTextMessage;
  @override
  final CustomerModel? customer;
  @override
  final String? status;
  @override
  final TCEUserModel? owner;

  @override
  String toString() {
    return 'RepairOrderConversationModel(messages: $messages, lastTextMessage: $lastTextMessage, customer: $customer, status: $status, owner: $owner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepairOrderConversationModel &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other.lastTextMessage, lastTextMessage) &&
            const DeepCollectionEquality().equals(other.customer, customer) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.owner, owner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(lastTextMessage),
      const DeepCollectionEquality().hash(customer),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(owner));

  @JsonKey(ignore: true)
  @override
  _$$_RepairOrderConversationModelCopyWith<_$_RepairOrderConversationModel>
      get copyWith => __$$_RepairOrderConversationModelCopyWithImpl<
          _$_RepairOrderConversationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RepairOrderConversationModelToJson(this);
  }
}

abstract class _RepairOrderConversationModel
    extends RepairOrderConversationModel {
  const factory _RepairOrderConversationModel(
      {final List<TextMessageModel>? messages,
      final TextMessageModel? lastTextMessage,
      final CustomerModel? customer,
      final String? status,
      final TCEUserModel? owner}) = _$_RepairOrderConversationModel;
  const _RepairOrderConversationModel._() : super._();

  factory _RepairOrderConversationModel.fromJson(Map<String, dynamic> json) =
      _$_RepairOrderConversationModel.fromJson;

  @override
  List<TextMessageModel>? get messages => throw _privateConstructorUsedError;
  @override
  TextMessageModel? get lastTextMessage => throw _privateConstructorUsedError;
  @override
  CustomerModel? get customer => throw _privateConstructorUsedError;
  @override
  String? get status => throw _privateConstructorUsedError;
  @override
  TCEUserModel? get owner => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RepairOrderConversationModelCopyWith<_$_RepairOrderConversationModel>
      get copyWith => throw _privateConstructorUsedError;
}
