// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'available_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AvailableOption _$AvailableOptionFromJson(Map<String, dynamic> json) {
  return _AvailableOption.fromJson(json);
}

/// @nodoc
mixin _$AvailableOption {
  String get uid => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  dynamic get enabled => throw _privateConstructorUsedError;
  List<ConfigItem> get config => throw _privateConstructorUsedError;
  bool get selectedValue => throw _privateConstructorUsedError;
  List<AvailableOption> get availableOptions =>
      throw _privateConstructorUsedError;
  List<ExtraNote> get extraNotes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvailableOptionCopyWith<AvailableOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableOptionCopyWith<$Res> {
  factory $AvailableOptionCopyWith(
          AvailableOption value, $Res Function(AvailableOption) then) =
      _$AvailableOptionCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String type,
      dynamic enabled,
      List<ConfigItem> config,
      bool selectedValue,
      List<AvailableOption> availableOptions,
      List<ExtraNote> extraNotes});
}

/// @nodoc
class _$AvailableOptionCopyWithImpl<$Res>
    implements $AvailableOptionCopyWith<$Res> {
  _$AvailableOptionCopyWithImpl(this._value, this._then);

  final AvailableOption _value;
  // ignore: unused_field
  final $Res Function(AvailableOption) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? type = freezed,
    Object? enabled = freezed,
    Object? config = freezed,
    Object? selectedValue = freezed,
    Object? availableOptions = freezed,
    Object? extraNotes = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as dynamic,
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as List<ConfigItem>,
      selectedValue: selectedValue == freezed
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as bool,
      availableOptions: availableOptions == freezed
          ? _value.availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as List<AvailableOption>,
      extraNotes: extraNotes == freezed
          ? _value.extraNotes
          : extraNotes // ignore: cast_nullable_to_non_nullable
              as List<ExtraNote>,
    ));
  }
}

/// @nodoc
abstract class _$$_AvailableOptionCopyWith<$Res>
    implements $AvailableOptionCopyWith<$Res> {
  factory _$$_AvailableOptionCopyWith(
          _$_AvailableOption value, $Res Function(_$_AvailableOption) then) =
      __$$_AvailableOptionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String type,
      dynamic enabled,
      List<ConfigItem> config,
      bool selectedValue,
      List<AvailableOption> availableOptions,
      List<ExtraNote> extraNotes});
}

/// @nodoc
class __$$_AvailableOptionCopyWithImpl<$Res>
    extends _$AvailableOptionCopyWithImpl<$Res>
    implements _$$_AvailableOptionCopyWith<$Res> {
  __$$_AvailableOptionCopyWithImpl(
      _$_AvailableOption _value, $Res Function(_$_AvailableOption) _then)
      : super(_value, (v) => _then(v as _$_AvailableOption));

  @override
  _$_AvailableOption get _value => super._value as _$_AvailableOption;

  @override
  $Res call({
    Object? uid = freezed,
    Object? type = freezed,
    Object? enabled = freezed,
    Object? config = freezed,
    Object? selectedValue = freezed,
    Object? availableOptions = freezed,
    Object? extraNotes = freezed,
  }) {
    return _then(_$_AvailableOption(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: enabled == freezed ? _value.enabled : enabled,
      config: config == freezed
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as List<ConfigItem>,
      selectedValue: selectedValue == freezed
          ? _value.selectedValue
          : selectedValue // ignore: cast_nullable_to_non_nullable
              as bool,
      availableOptions: availableOptions == freezed
          ? _value._availableOptions
          : availableOptions // ignore: cast_nullable_to_non_nullable
              as List<AvailableOption>,
      extraNotes: extraNotes == freezed
          ? _value._extraNotes
          : extraNotes // ignore: cast_nullable_to_non_nullable
              as List<ExtraNote>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_AvailableOption extends _AvailableOption {
  const _$_AvailableOption(
      {this.uid = "",
      this.type = "",
      this.enabled = true,
      final List<ConfigItem> config = const <ConfigItem>[],
      this.selectedValue = false,
      final List<AvailableOption> availableOptions = const <AvailableOption>[],
      final List<ExtraNote> extraNotes = const <ExtraNote>[]})
      : _config = config,
        _availableOptions = availableOptions,
        _extraNotes = extraNotes,
        super._();

  factory _$_AvailableOption.fromJson(Map<String, dynamic> json) =>
      _$$_AvailableOptionFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final dynamic enabled;
  final List<ConfigItem> _config;
  @override
  @JsonKey()
  List<ConfigItem> get config {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_config);
  }

  @override
  @JsonKey()
  final bool selectedValue;
  final List<AvailableOption> _availableOptions;
  @override
  @JsonKey()
  List<AvailableOption> get availableOptions {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableOptions);
  }

  final List<ExtraNote> _extraNotes;
  @override
  @JsonKey()
  List<ExtraNote> get extraNotes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_extraNotes);
  }

  @override
  String toString() {
    return 'AvailableOption(uid: $uid, type: $type, enabled: $enabled, config: $config, selectedValue: $selectedValue, availableOptions: $availableOptions, extraNotes: $extraNotes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AvailableOption &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            const DeepCollectionEquality()
                .equals(other.selectedValue, selectedValue) &&
            const DeepCollectionEquality()
                .equals(other._availableOptions, _availableOptions) &&
            const DeepCollectionEquality()
                .equals(other._extraNotes, _extraNotes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(_config),
      const DeepCollectionEquality().hash(selectedValue),
      const DeepCollectionEquality().hash(_availableOptions),
      const DeepCollectionEquality().hash(_extraNotes));

  @JsonKey(ignore: true)
  @override
  _$$_AvailableOptionCopyWith<_$_AvailableOption> get copyWith =>
      __$$_AvailableOptionCopyWithImpl<_$_AvailableOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvailableOptionToJson(this);
  }
}

abstract class _AvailableOption extends AvailableOption {
  const factory _AvailableOption(
      {final String uid,
      final String type,
      final dynamic enabled,
      final List<ConfigItem> config,
      final bool selectedValue,
      final List<AvailableOption> availableOptions,
      final List<ExtraNote> extraNotes}) = _$_AvailableOption;
  const _AvailableOption._() : super._();

  factory _AvailableOption.fromJson(Map<String, dynamic> json) =
      _$_AvailableOption.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  dynamic get enabled => throw _privateConstructorUsedError;
  @override
  List<ConfigItem> get config => throw _privateConstructorUsedError;
  @override
  bool get selectedValue => throw _privateConstructorUsedError;
  @override
  List<AvailableOption> get availableOptions =>
      throw _privateConstructorUsedError;
  @override
  List<ExtraNote> get extraNotes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AvailableOptionCopyWith<_$_AvailableOption> get copyWith =>
      throw _privateConstructorUsedError;
}
