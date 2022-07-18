// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'extra_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExtraNote _$ExtraNoteFromJson(Map<String, dynamic> json) {
  return _ExtraNote.fromJson(json);
}

/// @nodoc
mixin _$ExtraNote {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get style => throw _privateConstructorUsedError;
  List<ExtraNoteConfig> get config => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtraNoteCopyWith<ExtraNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraNoteCopyWith<$Res> {
  factory $ExtraNoteCopyWith(ExtraNote value, $Res Function(ExtraNote) then) =
      _$ExtraNoteCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String name,
      String description,
      String text,
      String style,
      List<ExtraNoteConfig> config});
}

/// @nodoc
class _$ExtraNoteCopyWithImpl<$Res> implements $ExtraNoteCopyWith<$Res> {
  _$ExtraNoteCopyWithImpl(this._value, this._then);

  final ExtraNote _value;
  // ignore: unused_field
  final $Res Function(ExtraNote) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? text = freezed,
    Object? style = freezed,
    Object? config = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as List<ExtraNoteConfig>,
    ));
  }
}

/// @nodoc
abstract class _$$_ExtraNoteCopyWith<$Res> implements $ExtraNoteCopyWith<$Res> {
  factory _$$_ExtraNoteCopyWith(
          _$_ExtraNote value, $Res Function(_$_ExtraNote) then) =
      __$$_ExtraNoteCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String name,
      String description,
      String text,
      String style,
      List<ExtraNoteConfig> config});
}

/// @nodoc
class __$$_ExtraNoteCopyWithImpl<$Res> extends _$ExtraNoteCopyWithImpl<$Res>
    implements _$$_ExtraNoteCopyWith<$Res> {
  __$$_ExtraNoteCopyWithImpl(
      _$_ExtraNote _value, $Res Function(_$_ExtraNote) _then)
      : super(_value, (v) => _then(v as _$_ExtraNote));

  @override
  _$_ExtraNote get _value => super._value as _$_ExtraNote;

  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? text = freezed,
    Object? style = freezed,
    Object? config = freezed,
  }) {
    return _then(_$_ExtraNote(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      style: style == freezed
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as String,
      config: config == freezed
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as List<ExtraNoteConfig>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ExtraNote extends _ExtraNote {
  const _$_ExtraNote(
      {required this.uid,
      this.name = "",
      this.description = "",
      this.text = "",
      this.style = "",
      final List<ExtraNoteConfig> config = const <ExtraNoteConfig>[]})
      : _config = config,
        super._();

  factory _$_ExtraNote.fromJson(Map<String, dynamic> json) =>
      _$$_ExtraNoteFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String style;
  final List<ExtraNoteConfig> _config;
  @override
  @JsonKey()
  List<ExtraNoteConfig> get config {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_config);
  }

  @override
  String toString() {
    return 'ExtraNote(uid: $uid, name: $name, description: $description, text: $text, style: $style, config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExtraNote &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.style, style) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(style),
      const DeepCollectionEquality().hash(_config));

  @JsonKey(ignore: true)
  @override
  _$$_ExtraNoteCopyWith<_$_ExtraNote> get copyWith =>
      __$$_ExtraNoteCopyWithImpl<_$_ExtraNote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExtraNoteToJson(this);
  }
}

abstract class _ExtraNote extends ExtraNote {
  const factory _ExtraNote(
      {required final String uid,
      final String name,
      final String description,
      final String text,
      final String style,
      final List<ExtraNoteConfig> config}) = _$_ExtraNote;
  const _ExtraNote._() : super._();

  factory _ExtraNote.fromJson(Map<String, dynamic> json) =
      _$_ExtraNote.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get style => throw _privateConstructorUsedError;
  @override
  List<ExtraNoteConfig> get config => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ExtraNoteCopyWith<_$_ExtraNote> get copyWith =>
      throw _privateConstructorUsedError;
}
