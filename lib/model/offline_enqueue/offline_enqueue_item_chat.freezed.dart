// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'offline_enqueue_item_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OfflineEnqueueItemChatModel _$OfflineEnqueueItemChatModelFromJson(
    Map<String, dynamic> json) {
  return _OfflineEnqueueItemChatModel.fromJson(json);
}

/// @nodoc
mixin _$OfflineEnqueueItemChatModel {
  String get text => throw _privateConstructorUsedError;
  String get accountUID => throw _privateConstructorUsedError;
  String get channelUID => throw _privateConstructorUsedError;
  String get auxUID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfflineEnqueueItemChatModelCopyWith<OfflineEnqueueItemChatModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineEnqueueItemChatModelCopyWith<$Res> {
  factory $OfflineEnqueueItemChatModelCopyWith(
          OfflineEnqueueItemChatModel value,
          $Res Function(OfflineEnqueueItemChatModel) then) =
      _$OfflineEnqueueItemChatModelCopyWithImpl<$Res>;
  $Res call({String text, String accountUID, String channelUID, String auxUID});
}

/// @nodoc
class _$OfflineEnqueueItemChatModelCopyWithImpl<$Res>
    implements $OfflineEnqueueItemChatModelCopyWith<$Res> {
  _$OfflineEnqueueItemChatModelCopyWithImpl(this._value, this._then);

  final OfflineEnqueueItemChatModel _value;
  // ignore: unused_field
  final $Res Function(OfflineEnqueueItemChatModel) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? accountUID = freezed,
    Object? channelUID = freezed,
    Object? auxUID = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      channelUID: channelUID == freezed
          ? _value.channelUID
          : channelUID // ignore: cast_nullable_to_non_nullable
              as String,
      auxUID: auxUID == freezed
          ? _value.auxUID
          : auxUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_OfflineEnqueueItemChatModelCopyWith<$Res>
    implements $OfflineEnqueueItemChatModelCopyWith<$Res> {
  factory _$$_OfflineEnqueueItemChatModelCopyWith(
          _$_OfflineEnqueueItemChatModel value,
          $Res Function(_$_OfflineEnqueueItemChatModel) then) =
      __$$_OfflineEnqueueItemChatModelCopyWithImpl<$Res>;
  @override
  $Res call({String text, String accountUID, String channelUID, String auxUID});
}

/// @nodoc
class __$$_OfflineEnqueueItemChatModelCopyWithImpl<$Res>
    extends _$OfflineEnqueueItemChatModelCopyWithImpl<$Res>
    implements _$$_OfflineEnqueueItemChatModelCopyWith<$Res> {
  __$$_OfflineEnqueueItemChatModelCopyWithImpl(
      _$_OfflineEnqueueItemChatModel _value,
      $Res Function(_$_OfflineEnqueueItemChatModel) _then)
      : super(_value, (v) => _then(v as _$_OfflineEnqueueItemChatModel));

  @override
  _$_OfflineEnqueueItemChatModel get _value =>
      super._value as _$_OfflineEnqueueItemChatModel;

  @override
  $Res call({
    Object? text = freezed,
    Object? accountUID = freezed,
    Object? channelUID = freezed,
    Object? auxUID = freezed,
  }) {
    return _then(_$_OfflineEnqueueItemChatModel(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      channelUID: channelUID == freezed
          ? _value.channelUID
          : channelUID // ignore: cast_nullable_to_non_nullable
              as String,
      auxUID: auxUID == freezed
          ? _value.auxUID
          : auxUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_OfflineEnqueueItemChatModel extends _OfflineEnqueueItemChatModel {
  const _$_OfflineEnqueueItemChatModel(
      {this.text = "",
      this.accountUID = "",
      this.channelUID = "",
      this.auxUID = ""})
      : super._();

  factory _$_OfflineEnqueueItemChatModel.fromJson(Map<String, dynamic> json) =>
      _$$_OfflineEnqueueItemChatModelFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String accountUID;
  @override
  @JsonKey()
  final String channelUID;
  @override
  @JsonKey()
  final String auxUID;

  @override
  String toString() {
    return 'OfflineEnqueueItemChatModel(text: $text, accountUID: $accountUID, channelUID: $channelUID, auxUID: $auxUID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfflineEnqueueItemChatModel &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality()
                .equals(other.accountUID, accountUID) &&
            const DeepCollectionEquality()
                .equals(other.channelUID, channelUID) &&
            const DeepCollectionEquality().equals(other.auxUID, auxUID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(accountUID),
      const DeepCollectionEquality().hash(channelUID),
      const DeepCollectionEquality().hash(auxUID));

  @JsonKey(ignore: true)
  @override
  _$$_OfflineEnqueueItemChatModelCopyWith<_$_OfflineEnqueueItemChatModel>
      get copyWith => __$$_OfflineEnqueueItemChatModelCopyWithImpl<
          _$_OfflineEnqueueItemChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfflineEnqueueItemChatModelToJson(this);
  }
}

abstract class _OfflineEnqueueItemChatModel
    extends OfflineEnqueueItemChatModel {
  const factory _OfflineEnqueueItemChatModel(
      {final String text,
      final String accountUID,
      final String channelUID,
      final String auxUID}) = _$_OfflineEnqueueItemChatModel;
  const _OfflineEnqueueItemChatModel._() : super._();

  factory _OfflineEnqueueItemChatModel.fromJson(Map<String, dynamic> json) =
      _$_OfflineEnqueueItemChatModel.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get accountUID => throw _privateConstructorUsedError;
  @override
  String get channelUID => throw _privateConstructorUsedError;
  @override
  String get auxUID => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_OfflineEnqueueItemChatModelCopyWith<_$_OfflineEnqueueItemChatModel>
      get copyWith => throw _privateConstructorUsedError;
}
