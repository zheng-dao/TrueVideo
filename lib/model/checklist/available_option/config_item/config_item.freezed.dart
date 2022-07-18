// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'config_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConfigItem _$ConfigItemFromJson(Map<String, dynamic> json) {
  return _ConfigItem.fromJson(json);
}

/// @nodoc
mixin _$ConfigItem {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get colorName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: "class")
  dynamic get classObject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigItemCopyWith<ConfigItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigItemCopyWith<$Res> {
  factory $ConfigItemCopyWith(
          ConfigItem value, $Res Function(ConfigItem) then) =
      _$ConfigItemCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String type,
      String colorName,
      String description,
      String displayName,
      @JsonKey(name: "class") dynamic classObject});
}

/// @nodoc
class _$ConfigItemCopyWithImpl<$Res> implements $ConfigItemCopyWith<$Res> {
  _$ConfigItemCopyWithImpl(this._value, this._then);

  final ConfigItem _value;
  // ignore: unused_field
  final $Res Function(ConfigItem) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? colorName = freezed,
    Object? description = freezed,
    Object? displayName = freezed,
    Object? classObject = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      colorName: colorName == freezed
          ? _value.colorName
          : colorName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      classObject: classObject == freezed
          ? _value.classObject
          : classObject // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_ConfigItemCopyWith<$Res>
    implements $ConfigItemCopyWith<$Res> {
  factory _$$_ConfigItemCopyWith(
          _$_ConfigItem value, $Res Function(_$_ConfigItem) then) =
      __$$_ConfigItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String type,
      String colorName,
      String description,
      String displayName,
      @JsonKey(name: "class") dynamic classObject});
}

/// @nodoc
class __$$_ConfigItemCopyWithImpl<$Res> extends _$ConfigItemCopyWithImpl<$Res>
    implements _$$_ConfigItemCopyWith<$Res> {
  __$$_ConfigItemCopyWithImpl(
      _$_ConfigItem _value, $Res Function(_$_ConfigItem) _then)
      : super(_value, (v) => _then(v as _$_ConfigItem));

  @override
  _$_ConfigItem get _value => super._value as _$_ConfigItem;

  @override
  $Res call({
    Object? name = freezed,
    Object? type = freezed,
    Object? colorName = freezed,
    Object? description = freezed,
    Object? displayName = freezed,
    Object? classObject = freezed,
  }) {
    return _then(_$_ConfigItem(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      colorName: colorName == freezed
          ? _value.colorName
          : colorName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
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
class _$_ConfigItem extends _ConfigItem {
  const _$_ConfigItem(
      {this.name = "",
      this.type = "",
      this.colorName = "",
      this.description = "",
      this.displayName = "",
      @JsonKey(name: "class") this.classObject})
      : super._();

  factory _$_ConfigItem.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigItemFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String colorName;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey(name: "class")
  final dynamic classObject;

  @override
  String toString() {
    return 'ConfigItem(name: $name, type: $type, colorName: $colorName, description: $description, displayName: $displayName, classObject: $classObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConfigItem &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.colorName, colorName) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality()
                .equals(other.classObject, classObject));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(colorName),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(classObject));

  @JsonKey(ignore: true)
  @override
  _$$_ConfigItemCopyWith<_$_ConfigItem> get copyWith =>
      __$$_ConfigItemCopyWithImpl<_$_ConfigItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigItemToJson(this);
  }
}

abstract class _ConfigItem extends ConfigItem {
  const factory _ConfigItem(
      {final String name,
      final String type,
      final String colorName,
      final String description,
      final String displayName,
      @JsonKey(name: "class") final dynamic classObject}) = _$_ConfigItem;
  const _ConfigItem._() : super._();

  factory _ConfigItem.fromJson(Map<String, dynamic> json) =
      _$_ConfigItem.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  String get colorName => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "class")
  dynamic get classObject => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigItemCopyWith<_$_ConfigItem> get copyWith =>
      throw _privateConstructorUsedError;
}
