// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_authentication_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageAuthenticationInformationModel
    _$MessageAuthenticationInformationModelFromJson(Map<String, dynamic> json) {
  return _MessageAuthenticationInformationModel.fromJson(json);
}

/// @nodoc
mixin _$MessageAuthenticationInformationModel {
  String get accountUID => throw _privateConstructorUsedError;
  String get subAccountUID => throw _privateConstructorUsedError;
  List<String> get groups => throw _privateConstructorUsedError;
  bool get authenticated => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  MessageAuthenticationInformationSubEntityModel?
      get subAccountMessageableEntity => throw _privateConstructorUsedError;
  MessageAuthenticationInformationSubEntityModel?
      get subjectMessageableEntity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageAuthenticationInformationModelCopyWith<
          MessageAuthenticationInformationModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAuthenticationInformationModelCopyWith<$Res> {
  factory $MessageAuthenticationInformationModelCopyWith(
          MessageAuthenticationInformationModel value,
          $Res Function(MessageAuthenticationInformationModel) then) =
      _$MessageAuthenticationInformationModelCopyWithImpl<$Res>;
  $Res call(
      {String accountUID,
      String subAccountUID,
      List<String> groups,
      bool authenticated,
      String provider,
      MessageAuthenticationInformationSubEntityModel?
          subAccountMessageableEntity,
      MessageAuthenticationInformationSubEntityModel?
          subjectMessageableEntity});

  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subAccountMessageableEntity;
  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subjectMessageableEntity;
}

/// @nodoc
class _$MessageAuthenticationInformationModelCopyWithImpl<$Res>
    implements $MessageAuthenticationInformationModelCopyWith<$Res> {
  _$MessageAuthenticationInformationModelCopyWithImpl(this._value, this._then);

  final MessageAuthenticationInformationModel _value;
  // ignore: unused_field
  final $Res Function(MessageAuthenticationInformationModel) _then;

  @override
  $Res call({
    Object? accountUID = freezed,
    Object? subAccountUID = freezed,
    Object? groups = freezed,
    Object? authenticated = freezed,
    Object? provider = freezed,
    Object? subAccountMessageableEntity = freezed,
    Object? subjectMessageableEntity = freezed,
  }) {
    return _then(_value.copyWith(
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      subAccountUID: subAccountUID == freezed
          ? _value.subAccountUID
          : subAccountUID // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: provider == freezed
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      subAccountMessageableEntity: subAccountMessageableEntity == freezed
          ? _value.subAccountMessageableEntity
          : subAccountMessageableEntity // ignore: cast_nullable_to_non_nullable
              as MessageAuthenticationInformationSubEntityModel?,
      subjectMessageableEntity: subjectMessageableEntity == freezed
          ? _value.subjectMessageableEntity
          : subjectMessageableEntity // ignore: cast_nullable_to_non_nullable
              as MessageAuthenticationInformationSubEntityModel?,
    ));
  }

  @override
  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subAccountMessageableEntity {
    if (_value.subAccountMessageableEntity == null) {
      return null;
    }

    return $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>(
        _value.subAccountMessageableEntity!, (value) {
      return _then(_value.copyWith(subAccountMessageableEntity: value));
    });
  }

  @override
  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subjectMessageableEntity {
    if (_value.subjectMessageableEntity == null) {
      return null;
    }

    return $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>(
        _value.subjectMessageableEntity!, (value) {
      return _then(_value.copyWith(subjectMessageableEntity: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageAuthenticationInformationModelCopyWith<$Res>
    implements $MessageAuthenticationInformationModelCopyWith<$Res> {
  factory _$$_MessageAuthenticationInformationModelCopyWith(
          _$_MessageAuthenticationInformationModel value,
          $Res Function(_$_MessageAuthenticationInformationModel) then) =
      __$$_MessageAuthenticationInformationModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String accountUID,
      String subAccountUID,
      List<String> groups,
      bool authenticated,
      String provider,
      MessageAuthenticationInformationSubEntityModel?
          subAccountMessageableEntity,
      MessageAuthenticationInformationSubEntityModel?
          subjectMessageableEntity});

  @override
  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subAccountMessageableEntity;
  @override
  $MessageAuthenticationInformationSubEntityModelCopyWith<$Res>?
      get subjectMessageableEntity;
}

/// @nodoc
class __$$_MessageAuthenticationInformationModelCopyWithImpl<$Res>
    extends _$MessageAuthenticationInformationModelCopyWithImpl<$Res>
    implements _$$_MessageAuthenticationInformationModelCopyWith<$Res> {
  __$$_MessageAuthenticationInformationModelCopyWithImpl(
      _$_MessageAuthenticationInformationModel _value,
      $Res Function(_$_MessageAuthenticationInformationModel) _then)
      : super(_value,
            (v) => _then(v as _$_MessageAuthenticationInformationModel));

  @override
  _$_MessageAuthenticationInformationModel get _value =>
      super._value as _$_MessageAuthenticationInformationModel;

  @override
  $Res call({
    Object? accountUID = freezed,
    Object? subAccountUID = freezed,
    Object? groups = freezed,
    Object? authenticated = freezed,
    Object? provider = freezed,
    Object? subAccountMessageableEntity = freezed,
    Object? subjectMessageableEntity = freezed,
  }) {
    return _then(_$_MessageAuthenticationInformationModel(
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      subAccountUID: subAccountUID == freezed
          ? _value.subAccountUID
          : subAccountUID // ignore: cast_nullable_to_non_nullable
              as String,
      groups: groups == freezed
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
      authenticated: authenticated == freezed
          ? _value.authenticated
          : authenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      provider: provider == freezed
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String,
      subAccountMessageableEntity: subAccountMessageableEntity == freezed
          ? _value.subAccountMessageableEntity
          : subAccountMessageableEntity // ignore: cast_nullable_to_non_nullable
              as MessageAuthenticationInformationSubEntityModel?,
      subjectMessageableEntity: subjectMessageableEntity == freezed
          ? _value.subjectMessageableEntity
          : subjectMessageableEntity // ignore: cast_nullable_to_non_nullable
              as MessageAuthenticationInformationSubEntityModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageAuthenticationInformationModel
    extends _MessageAuthenticationInformationModel {
  const _$_MessageAuthenticationInformationModel(
      {this.accountUID = "",
      this.subAccountUID = "",
      final List<String> groups = const <String>[],
      this.authenticated = false,
      this.provider = "",
      this.subAccountMessageableEntity,
      this.subjectMessageableEntity})
      : _groups = groups,
        super._();

  factory _$_MessageAuthenticationInformationModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_MessageAuthenticationInformationModelFromJson(json);

  @override
  @JsonKey()
  final String accountUID;
  @override
  @JsonKey()
  final String subAccountUID;
  final List<String> _groups;
  @override
  @JsonKey()
  List<String> get groups {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  @JsonKey()
  final bool authenticated;
  @override
  @JsonKey()
  final String provider;
  @override
  final MessageAuthenticationInformationSubEntityModel?
      subAccountMessageableEntity;
  @override
  final MessageAuthenticationInformationSubEntityModel?
      subjectMessageableEntity;

  @override
  String toString() {
    return 'MessageAuthenticationInformationModel(accountUID: $accountUID, subAccountUID: $subAccountUID, groups: $groups, authenticated: $authenticated, provider: $provider, subAccountMessageableEntity: $subAccountMessageableEntity, subjectMessageableEntity: $subjectMessageableEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageAuthenticationInformationModel &&
            const DeepCollectionEquality()
                .equals(other.accountUID, accountUID) &&
            const DeepCollectionEquality()
                .equals(other.subAccountUID, subAccountUID) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            const DeepCollectionEquality()
                .equals(other.authenticated, authenticated) &&
            const DeepCollectionEquality().equals(other.provider, provider) &&
            const DeepCollectionEquality().equals(
                other.subAccountMessageableEntity,
                subAccountMessageableEntity) &&
            const DeepCollectionEquality().equals(
                other.subjectMessageableEntity, subjectMessageableEntity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accountUID),
      const DeepCollectionEquality().hash(subAccountUID),
      const DeepCollectionEquality().hash(_groups),
      const DeepCollectionEquality().hash(authenticated),
      const DeepCollectionEquality().hash(provider),
      const DeepCollectionEquality().hash(subAccountMessageableEntity),
      const DeepCollectionEquality().hash(subjectMessageableEntity));

  @JsonKey(ignore: true)
  @override
  _$$_MessageAuthenticationInformationModelCopyWith<
          _$_MessageAuthenticationInformationModel>
      get copyWith => __$$_MessageAuthenticationInformationModelCopyWithImpl<
          _$_MessageAuthenticationInformationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageAuthenticationInformationModelToJson(this);
  }
}

abstract class _MessageAuthenticationInformationModel
    extends MessageAuthenticationInformationModel {
  const factory _MessageAuthenticationInformationModel(
      {final String accountUID,
      final String subAccountUID,
      final List<String> groups,
      final bool authenticated,
      final String provider,
      final MessageAuthenticationInformationSubEntityModel?
          subAccountMessageableEntity,
      final MessageAuthenticationInformationSubEntityModel?
          subjectMessageableEntity}) = _$_MessageAuthenticationInformationModel;
  const _MessageAuthenticationInformationModel._() : super._();

  factory _MessageAuthenticationInformationModel.fromJson(
          Map<String, dynamic> json) =
      _$_MessageAuthenticationInformationModel.fromJson;

  @override
  String get accountUID => throw _privateConstructorUsedError;
  @override
  String get subAccountUID => throw _privateConstructorUsedError;
  @override
  List<String> get groups => throw _privateConstructorUsedError;
  @override
  bool get authenticated => throw _privateConstructorUsedError;
  @override
  String get provider => throw _privateConstructorUsedError;
  @override
  MessageAuthenticationInformationSubEntityModel?
      get subAccountMessageableEntity => throw _privateConstructorUsedError;
  @override
  MessageAuthenticationInformationSubEntityModel?
      get subjectMessageableEntity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageAuthenticationInformationModelCopyWith<
          _$_MessageAuthenticationInformationModel>
      get copyWith => throw _privateConstructorUsedError;
}
