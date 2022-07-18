// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserSettingsModel _$UserSettingsModelFromJson(Map<String, dynamic> json) {
  return _UserSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$UserSettingsModel {
  String get key => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<UserSettingsModel>? get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSettingsModelCopyWith<UserSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsModelCopyWith<$Res> {
  factory $UserSettingsModelCopyWith(
          UserSettingsModel value, $Res Function(UserSettingsModel) then) =
      _$UserSettingsModelCopyWithImpl<$Res>;
  $Res call(
      {String key,
      String? value,
      String? displayName,
      String type,
      List<UserSettingsModel>? children});
}

/// @nodoc
class _$UserSettingsModelCopyWithImpl<$Res>
    implements $UserSettingsModelCopyWith<$Res> {
  _$UserSettingsModelCopyWithImpl(this._value, this._then);

  final UserSettingsModel _value;
  // ignore: unused_field
  final $Res Function(UserSettingsModel) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
    Object? type = freezed,
    Object? children = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      children: children == freezed
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<UserSettingsModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserSettingsModelCopyWith<$Res>
    implements $UserSettingsModelCopyWith<$Res> {
  factory _$$_UserSettingsModelCopyWith(_$_UserSettingsModel value,
          $Res Function(_$_UserSettingsModel) then) =
      __$$_UserSettingsModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String key,
      String? value,
      String? displayName,
      String type,
      List<UserSettingsModel>? children});
}

/// @nodoc
class __$$_UserSettingsModelCopyWithImpl<$Res>
    extends _$UserSettingsModelCopyWithImpl<$Res>
    implements _$$_UserSettingsModelCopyWith<$Res> {
  __$$_UserSettingsModelCopyWithImpl(
      _$_UserSettingsModel _value, $Res Function(_$_UserSettingsModel) _then)
      : super(_value, (v) => _then(v as _$_UserSettingsModel));

  @override
  _$_UserSettingsModel get _value => super._value as _$_UserSettingsModel;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
    Object? type = freezed,
    Object? children = freezed,
  }) {
    return _then(_$_UserSettingsModel(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      children: children == freezed
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<UserSettingsModel>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserSettingsModel extends _UserSettingsModel {
  const _$_UserSettingsModel(
      {this.key = "",
      this.value,
      this.displayName,
      this.type = "",
      final List<UserSettingsModel>? children})
      : _children = children,
        super._();

  factory _$_UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserSettingsModelFromJson(json);

  @override
  @JsonKey()
  final String key;
  @override
  final String? value;
  @override
  final String? displayName;
  @override
  @JsonKey()
  final String type;
  final List<UserSettingsModel>? _children;
  @override
  List<UserSettingsModel>? get children {
    final value = _children;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserSettingsModel(key: $key, value: $value, displayName: $displayName, type: $type, children: $children)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserSettingsModel &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  _$$_UserSettingsModelCopyWith<_$_UserSettingsModel> get copyWith =>
      __$$_UserSettingsModelCopyWithImpl<_$_UserSettingsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserSettingsModelToJson(this);
  }
}

abstract class _UserSettingsModel extends UserSettingsModel {
  const factory _UserSettingsModel(
      {final String key,
      final String? value,
      final String? displayName,
      final String type,
      final List<UserSettingsModel>? children}) = _$_UserSettingsModel;
  const _UserSettingsModel._() : super._();

  factory _UserSettingsModel.fromJson(Map<String, dynamic> json) =
      _$_UserSettingsModel.fromJson;

  @override
  String get key => throw _privateConstructorUsedError;
  @override
  String? get value => throw _privateConstructorUsedError;
  @override
  String? get displayName => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  List<UserSettingsModel>? get children => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_UserSettingsModelCopyWith<_$_UserSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
