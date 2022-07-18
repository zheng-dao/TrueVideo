// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'definitions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Definitions _$DefinitionsFromJson(Map<String, dynamic> json) {
  return _Definitions.fromJson(json);
}

/// @nodoc
mixin _$Definitions {
  List<Section> get sections => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DefinitionsCopyWith<Definitions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefinitionsCopyWith<$Res> {
  factory $DefinitionsCopyWith(
          Definitions value, $Res Function(Definitions) then) =
      _$DefinitionsCopyWithImpl<$Res>;
  $Res call({List<Section> sections});
}

/// @nodoc
class _$DefinitionsCopyWithImpl<$Res> implements $DefinitionsCopyWith<$Res> {
  _$DefinitionsCopyWithImpl(this._value, this._then);

  final Definitions _value;
  // ignore: unused_field
  final $Res Function(Definitions) _then;

  @override
  $Res call({
    Object? sections = freezed,
  }) {
    return _then(_value.copyWith(
      sections: sections == freezed
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
    ));
  }
}

/// @nodoc
abstract class _$$_DefinitionsCopyWith<$Res>
    implements $DefinitionsCopyWith<$Res> {
  factory _$$_DefinitionsCopyWith(
          _$_Definitions value, $Res Function(_$_Definitions) then) =
      __$$_DefinitionsCopyWithImpl<$Res>;
  @override
  $Res call({List<Section> sections});
}

/// @nodoc
class __$$_DefinitionsCopyWithImpl<$Res> extends _$DefinitionsCopyWithImpl<$Res>
    implements _$$_DefinitionsCopyWith<$Res> {
  __$$_DefinitionsCopyWithImpl(
      _$_Definitions _value, $Res Function(_$_Definitions) _then)
      : super(_value, (v) => _then(v as _$_Definitions));

  @override
  _$_Definitions get _value => super._value as _$_Definitions;

  @override
  $Res call({
    Object? sections = freezed,
  }) {
    return _then(_$_Definitions(
      sections: sections == freezed
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Definitions implements _Definitions {
  _$_Definitions({final List<Section> sections = const <Section>[]})
      : _sections = sections;

  factory _$_Definitions.fromJson(Map<String, dynamic> json) =>
      _$$_DefinitionsFromJson(json);

  final List<Section> _sections;
  @override
  @JsonKey()
  List<Section> get sections {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  String toString() {
    return 'Definitions(sections: $sections)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Definitions &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_sections));

  @JsonKey(ignore: true)
  @override
  _$$_DefinitionsCopyWith<_$_Definitions> get copyWith =>
      __$$_DefinitionsCopyWithImpl<_$_Definitions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DefinitionsToJson(this);
  }
}

abstract class _Definitions implements Definitions {
  factory _Definitions({final List<Section> sections}) = _$_Definitions;

  factory _Definitions.fromJson(Map<String, dynamic> json) =
      _$_Definitions.fromJson;

  @override
  List<Section> get sections => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DefinitionsCopyWith<_$_Definitions> get copyWith =>
      throw _privateConstructorUsedError;
}
