// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reply_extra_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReplyExtraNote _$ReplyExtraNoteFromJson(Map<String, dynamic> json) {
  return _ReplyExtraNote.fromJson(json);
}

/// @nodoc
mixin _$ReplyExtraNote {
  String get optionUID => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyExtraNoteCopyWith<ReplyExtraNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyExtraNoteCopyWith<$Res> {
  factory $ReplyExtraNoteCopyWith(
          ReplyExtraNote value, $Res Function(ReplyExtraNote) then) =
      _$ReplyExtraNoteCopyWithImpl<$Res>;
  $Res call({String optionUID, String? description});
}

/// @nodoc
class _$ReplyExtraNoteCopyWithImpl<$Res>
    implements $ReplyExtraNoteCopyWith<$Res> {
  _$ReplyExtraNoteCopyWithImpl(this._value, this._then);

  final ReplyExtraNote _value;
  // ignore: unused_field
  final $Res Function(ReplyExtraNote) _then;

  @override
  $Res call({
    Object? optionUID = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      optionUID: optionUID == freezed
          ? _value.optionUID
          : optionUID // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ReplyExtraNoteCopyWith<$Res>
    implements $ReplyExtraNoteCopyWith<$Res> {
  factory _$$_ReplyExtraNoteCopyWith(
          _$_ReplyExtraNote value, $Res Function(_$_ReplyExtraNote) then) =
      __$$_ReplyExtraNoteCopyWithImpl<$Res>;
  @override
  $Res call({String optionUID, String? description});
}

/// @nodoc
class __$$_ReplyExtraNoteCopyWithImpl<$Res>
    extends _$ReplyExtraNoteCopyWithImpl<$Res>
    implements _$$_ReplyExtraNoteCopyWith<$Res> {
  __$$_ReplyExtraNoteCopyWithImpl(
      _$_ReplyExtraNote _value, $Res Function(_$_ReplyExtraNote) _then)
      : super(_value, (v) => _then(v as _$_ReplyExtraNote));

  @override
  _$_ReplyExtraNote get _value => super._value as _$_ReplyExtraNote;

  @override
  $Res call({
    Object? optionUID = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_ReplyExtraNote(
      optionUID: optionUID == freezed
          ? _value.optionUID
          : optionUID // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ReplyExtraNote extends _ReplyExtraNote {
  const _$_ReplyExtraNote({this.optionUID = "", this.description}) : super._();

  factory _$_ReplyExtraNote.fromJson(Map<String, dynamic> json) =>
      _$$_ReplyExtraNoteFromJson(json);

  @override
  @JsonKey()
  final String optionUID;
  @override
  final String? description;

  @override
  String toString() {
    return 'ReplyExtraNote(optionUID: $optionUID, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReplyExtraNote &&
            const DeepCollectionEquality().equals(other.optionUID, optionUID) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(optionUID),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$_ReplyExtraNoteCopyWith<_$_ReplyExtraNote> get copyWith =>
      __$$_ReplyExtraNoteCopyWithImpl<_$_ReplyExtraNote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReplyExtraNoteToJson(this);
  }
}

abstract class _ReplyExtraNote extends ReplyExtraNote {
  const factory _ReplyExtraNote(
      {final String optionUID, final String? description}) = _$_ReplyExtraNote;
  const _ReplyExtraNote._() : super._();

  factory _ReplyExtraNote.fromJson(Map<String, dynamic> json) =
      _$_ReplyExtraNote.fromJson;

  @override
  String get optionUID => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ReplyExtraNoteCopyWith<_$_ReplyExtraNote> get copyWith =>
      throw _privateConstructorUsedError;
}
