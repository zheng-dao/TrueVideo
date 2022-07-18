// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'section_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SectionConfig _$SectionConfigFromJson(Map<String, dynamic> json) {
  return _SectionConfig.fromJson(json);
}

/// @nodoc
mixin _$SectionConfig {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get customName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int? get inputOrder => throw _privateConstructorUsedError;
  int? get outputOrder => throw _privateConstructorUsedError;
  bool get isPrintable => throw _privateConstructorUsedError;
  dynamic get visibleFor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SectionConfigCopyWith<SectionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionConfigCopyWith<$Res> {
  factory $SectionConfigCopyWith(
          SectionConfig value, $Res Function(SectionConfig) then) =
      _$SectionConfigCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String description,
      String customName,
      String type,
      int? inputOrder,
      int? outputOrder,
      bool isPrintable,
      dynamic visibleFor});
}

/// @nodoc
class _$SectionConfigCopyWithImpl<$Res>
    implements $SectionConfigCopyWith<$Res> {
  _$SectionConfigCopyWithImpl(this._value, this._then);

  final SectionConfig _value;
  // ignore: unused_field
  final $Res Function(SectionConfig) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? customName = freezed,
    Object? type = freezed,
    Object? inputOrder = freezed,
    Object? outputOrder = freezed,
    Object? isPrintable = freezed,
    Object? visibleFor = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      customName: customName == freezed
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      inputOrder: inputOrder == freezed
          ? _value.inputOrder
          : inputOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      outputOrder: outputOrder == freezed
          ? _value.outputOrder
          : outputOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      isPrintable: isPrintable == freezed
          ? _value.isPrintable
          : isPrintable // ignore: cast_nullable_to_non_nullable
              as bool,
      visibleFor: visibleFor == freezed
          ? _value.visibleFor
          : visibleFor // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_SectionConfigCopyWith<$Res>
    implements $SectionConfigCopyWith<$Res> {
  factory _$$_SectionConfigCopyWith(
          _$_SectionConfig value, $Res Function(_$_SectionConfig) then) =
      __$$_SectionConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String description,
      String customName,
      String type,
      int? inputOrder,
      int? outputOrder,
      bool isPrintable,
      dynamic visibleFor});
}

/// @nodoc
class __$$_SectionConfigCopyWithImpl<$Res>
    extends _$SectionConfigCopyWithImpl<$Res>
    implements _$$_SectionConfigCopyWith<$Res> {
  __$$_SectionConfigCopyWithImpl(
      _$_SectionConfig _value, $Res Function(_$_SectionConfig) _then)
      : super(_value, (v) => _then(v as _$_SectionConfig));

  @override
  _$_SectionConfig get _value => super._value as _$_SectionConfig;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? customName = freezed,
    Object? type = freezed,
    Object? inputOrder = freezed,
    Object? outputOrder = freezed,
    Object? isPrintable = freezed,
    Object? visibleFor = freezed,
  }) {
    return _then(_$_SectionConfig(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      customName: customName == freezed
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      inputOrder: inputOrder == freezed
          ? _value.inputOrder
          : inputOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      outputOrder: outputOrder == freezed
          ? _value.outputOrder
          : outputOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      isPrintable: isPrintable == freezed
          ? _value.isPrintable
          : isPrintable // ignore: cast_nullable_to_non_nullable
              as bool,
      visibleFor: visibleFor == freezed ? _value.visibleFor : visibleFor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SectionConfig implements _SectionConfig {
  _$_SectionConfig(
      {this.name = "",
      this.description = "",
      this.customName = "",
      this.type = "",
      this.inputOrder,
      this.outputOrder,
      this.isPrintable = true,
      this.visibleFor = ""});

  factory _$_SectionConfig.fromJson(Map<String, dynamic> json) =>
      _$$_SectionConfigFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String customName;
  @override
  @JsonKey()
  final String type;
  @override
  final int? inputOrder;
  @override
  final int? outputOrder;
  @override
  @JsonKey()
  final bool isPrintable;
  @override
  @JsonKey()
  final dynamic visibleFor;

  @override
  String toString() {
    return 'SectionConfig(name: $name, description: $description, customName: $customName, type: $type, inputOrder: $inputOrder, outputOrder: $outputOrder, isPrintable: $isPrintable, visibleFor: $visibleFor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SectionConfig &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.customName, customName) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.inputOrder, inputOrder) &&
            const DeepCollectionEquality()
                .equals(other.outputOrder, outputOrder) &&
            const DeepCollectionEquality()
                .equals(other.isPrintable, isPrintable) &&
            const DeepCollectionEquality()
                .equals(other.visibleFor, visibleFor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(customName),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(inputOrder),
      const DeepCollectionEquality().hash(outputOrder),
      const DeepCollectionEquality().hash(isPrintable),
      const DeepCollectionEquality().hash(visibleFor));

  @JsonKey(ignore: true)
  @override
  _$$_SectionConfigCopyWith<_$_SectionConfig> get copyWith =>
      __$$_SectionConfigCopyWithImpl<_$_SectionConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SectionConfigToJson(this);
  }
}

abstract class _SectionConfig implements SectionConfig {
  factory _SectionConfig(
      {final String name,
      final String description,
      final String customName,
      final String type,
      final int? inputOrder,
      final int? outputOrder,
      final bool isPrintable,
      final dynamic visibleFor}) = _$_SectionConfig;

  factory _SectionConfig.fromJson(Map<String, dynamic> json) =
      _$_SectionConfig.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get customName => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  int? get inputOrder => throw _privateConstructorUsedError;
  @override
  int? get outputOrder => throw _privateConstructorUsedError;
  @override
  bool get isPrintable => throw _privateConstructorUsedError;
  @override
  dynamic get visibleFor => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SectionConfigCopyWith<_$_SectionConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
