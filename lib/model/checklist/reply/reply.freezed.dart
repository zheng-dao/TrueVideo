// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return _Reply.fromJson(json);
}

/// @nodoc
mixin _$Reply {
  String get itemUID => throw _privateConstructorUsedError;
  List<ReplyExtraNote>? get replyExtraNote =>
      throw _privateConstructorUsedError;
  List<ReplyItemValues>? get replyItemValues =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyCopyWith<Reply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyCopyWith<$Res> {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) then) =
      _$ReplyCopyWithImpl<$Res>;
  $Res call(
      {String itemUID,
      List<ReplyExtraNote>? replyExtraNote,
      List<ReplyItemValues>? replyItemValues});
}

/// @nodoc
class _$ReplyCopyWithImpl<$Res> implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._value, this._then);

  final Reply _value;
  // ignore: unused_field
  final $Res Function(Reply) _then;

  @override
  $Res call({
    Object? itemUID = freezed,
    Object? replyExtraNote = freezed,
    Object? replyItemValues = freezed,
  }) {
    return _then(_value.copyWith(
      itemUID: itemUID == freezed
          ? _value.itemUID
          : itemUID // ignore: cast_nullable_to_non_nullable
              as String,
      replyExtraNote: replyExtraNote == freezed
          ? _value.replyExtraNote
          : replyExtraNote // ignore: cast_nullable_to_non_nullable
              as List<ReplyExtraNote>?,
      replyItemValues: replyItemValues == freezed
          ? _value.replyItemValues
          : replyItemValues // ignore: cast_nullable_to_non_nullable
              as List<ReplyItemValues>?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReplyCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$$_ReplyCopyWith(_$_Reply value, $Res Function(_$_Reply) then) =
      __$$_ReplyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String itemUID,
      List<ReplyExtraNote>? replyExtraNote,
      List<ReplyItemValues>? replyItemValues});
}

/// @nodoc
class __$$_ReplyCopyWithImpl<$Res> extends _$ReplyCopyWithImpl<$Res>
    implements _$$_ReplyCopyWith<$Res> {
  __$$_ReplyCopyWithImpl(_$_Reply _value, $Res Function(_$_Reply) _then)
      : super(_value, (v) => _then(v as _$_Reply));

  @override
  _$_Reply get _value => super._value as _$_Reply;

  @override
  $Res call({
    Object? itemUID = freezed,
    Object? replyExtraNote = freezed,
    Object? replyItemValues = freezed,
  }) {
    return _then(_$_Reply(
      itemUID: itemUID == freezed
          ? _value.itemUID
          : itemUID // ignore: cast_nullable_to_non_nullable
              as String,
      replyExtraNote: replyExtraNote == freezed
          ? _value._replyExtraNote
          : replyExtraNote // ignore: cast_nullable_to_non_nullable
              as List<ReplyExtraNote>?,
      replyItemValues: replyItemValues == freezed
          ? _value._replyItemValues
          : replyItemValues // ignore: cast_nullable_to_non_nullable
              as List<ReplyItemValues>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Reply extends _Reply {
  const _$_Reply(
      {required this.itemUID,
      final List<ReplyExtraNote>? replyExtraNote,
      final List<ReplyItemValues>? replyItemValues})
      : _replyExtraNote = replyExtraNote,
        _replyItemValues = replyItemValues,
        super._();

  factory _$_Reply.fromJson(Map<String, dynamic> json) =>
      _$$_ReplyFromJson(json);

  @override
  final String itemUID;
  final List<ReplyExtraNote>? _replyExtraNote;
  @override
  List<ReplyExtraNote>? get replyExtraNote {
    final value = _replyExtraNote;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ReplyItemValues>? _replyItemValues;
  @override
  List<ReplyItemValues>? get replyItemValues {
    final value = _replyItemValues;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Reply(itemUID: $itemUID, replyExtraNote: $replyExtraNote, replyItemValues: $replyItemValues)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reply &&
            const DeepCollectionEquality().equals(other.itemUID, itemUID) &&
            const DeepCollectionEquality()
                .equals(other._replyExtraNote, _replyExtraNote) &&
            const DeepCollectionEquality()
                .equals(other._replyItemValues, _replyItemValues));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(itemUID),
      const DeepCollectionEquality().hash(_replyExtraNote),
      const DeepCollectionEquality().hash(_replyItemValues));

  @JsonKey(ignore: true)
  @override
  _$$_ReplyCopyWith<_$_Reply> get copyWith =>
      __$$_ReplyCopyWithImpl<_$_Reply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReplyToJson(this);
  }
}

abstract class _Reply extends Reply {
  const factory _Reply(
      {required final String itemUID,
      final List<ReplyExtraNote>? replyExtraNote,
      final List<ReplyItemValues>? replyItemValues}) = _$_Reply;
  const _Reply._() : super._();

  factory _Reply.fromJson(Map<String, dynamic> json) = _$_Reply.fromJson;

  @override
  String get itemUID => throw _privateConstructorUsedError;
  @override
  List<ReplyExtraNote>? get replyExtraNote =>
      throw _privateConstructorUsedError;
  @override
  List<ReplyItemValues>? get replyItemValues =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReplyCopyWith<_$_Reply> get copyWith =>
      throw _privateConstructorUsedError;
}
