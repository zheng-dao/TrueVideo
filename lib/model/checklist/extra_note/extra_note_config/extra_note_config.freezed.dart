// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'extra_note_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExtraNoteConfig _$ExtraNoteConfigFromJson(Map<String, dynamic> json) {
  return _ExtraNoteConfig.fromJson(json);
}

/// @nodoc
mixin _$ExtraNoteConfig {
  String get displayName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: "class")
  dynamic get classObject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtraNoteConfigCopyWith<ExtraNoteConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtraNoteConfigCopyWith<$Res> {
  factory $ExtraNoteConfigCopyWith(
          ExtraNoteConfig value, $Res Function(ExtraNoteConfig) then) =
      _$ExtraNoteConfigCopyWithImpl<$Res>;
  $Res call(
      {String displayName,
      String name,
      String description,
      String type,
      @JsonKey(name: "class") dynamic classObject});
}

/// @nodoc
class _$ExtraNoteConfigCopyWithImpl<$Res>
    implements $ExtraNoteConfigCopyWith<$Res> {
  _$ExtraNoteConfigCopyWithImpl(this._value, this._then);

  final ExtraNoteConfig _value;
  // ignore: unused_field
  final $Res Function(ExtraNoteConfig) _then;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? classObject = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      classObject: classObject == freezed
          ? _value.classObject
          : classObject // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ExtraNoteConfigCopyWith<$Res>
    implements $ExtraNoteConfigCopyWith<$Res> {
  factory _$$_ExtraNoteConfigCopyWith(
          _$_ExtraNoteConfig value, $Res Function(_$_ExtraNoteConfig) then) =
      __$$_ExtraNoteConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String displayName,
      String name,
      String description,
      String type,
      @JsonKey(name: "class") dynamic classObject});
}

/// @nodoc
class __$$_ExtraNoteConfigCopyWithImpl<$Res>
    extends _$ExtraNoteConfigCopyWithImpl<$Res>
    implements _$$_ExtraNoteConfigCopyWith<$Res> {
  __$$_ExtraNoteConfigCopyWithImpl(
      _$_ExtraNoteConfig _value, $Res Function(_$_ExtraNoteConfig) _then)
      : super(_value, (v) => _then(v as _$_ExtraNoteConfig));

  @override
  _$_ExtraNoteConfig get _value => super._value as _$_ExtraNoteConfig;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? classObject = freezed,
  }) {
    return _then(_$_ExtraNoteConfig(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      classObject: classObject == freezed
          ? _value.classObject
          : classObject // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ExtraNoteConfig extends _ExtraNoteConfig {
  const _$_ExtraNoteConfig(
      {this.displayName = "",
      this.name = "",
      this.description = "",
      this.type = "",
      @JsonKey(name: "class") this.classObject})
      : super._();

  factory _$_ExtraNoteConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ExtraNoteConfigFromJson(json);

  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey(name: "class")
  final dynamic classObject;

  @override
  String toString() {
    return 'ExtraNoteConfig(displayName: $displayName, name: $name, description: $description, type: $type, classObject: $classObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExtraNoteConfig &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.classObject, classObject));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(classObject));

  @JsonKey(ignore: true)
  @override
  _$$_ExtraNoteConfigCopyWith<_$_ExtraNoteConfig> get copyWith =>
      __$$_ExtraNoteConfigCopyWithImpl<_$_ExtraNoteConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExtraNoteConfigToJson(this);
  }
}

abstract class _ExtraNoteConfig extends ExtraNoteConfig {
  const factory _ExtraNoteConfig(
      {final String displayName,
      final String name,
      final String description,
      final String type,
      @JsonKey(name: "class") final dynamic classObject}) = _$_ExtraNoteConfig;
  const _ExtraNoteConfig._() : super._();

  factory _ExtraNoteConfig.fromJson(Map<String, dynamic> json) =
      _$_ExtraNoteConfig.fromJson;

  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "class")
  dynamic get classObject => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ExtraNoteConfigCopyWith<_$_ExtraNoteConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
