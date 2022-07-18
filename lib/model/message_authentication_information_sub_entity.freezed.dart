// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_authentication_information_sub_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageAuthenticationInformationSubEntityModel
    _$MessageAuthenticationInformationSubEntityModelFromJson(
        Map<String, dynamic> json) {
  return _MessageAuthenticationInformationSubEntityModel.fromJson(json);
}

/// @nodoc
mixin _$MessageAuthenticationInformationSubEntityModel {
  MessageEntityReferenceModel? get businessReference =>
      throw _privateConstructorUsedError;
  String get subAccountUID => throw _privateConstructorUsedError;
  String get accountUID => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageAuthenticationInformationSubEntityModelCopyWith<
          MessageAuthenticationInformationSubEntityModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAuthenticationInformationSubEntityModelCopyWith<$Res> {
  factory $MessageAuthenticationInformationSubEntityModelCopyWith(
          MessageAuthenticationInformationSubEntityModel value,
          $Res Function(MessageAuthenticationInformationSubEntityModel) then) =
      _$MessageAuthenticationInformationSubEntityModelCopyWithImpl<$Res>;
  $Res call(
      {MessageEntityReferenceModel? businessReference,
      String subAccountUID,
      String accountUID,
      String uid,
      String displayName,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});

  $MessageEntityReferenceModelCopyWith<$Res>? get businessReference;
}

/// @nodoc
class _$MessageAuthenticationInformationSubEntityModelCopyWithImpl<$Res>
    implements $MessageAuthenticationInformationSubEntityModelCopyWith<$Res> {
  _$MessageAuthenticationInformationSubEntityModelCopyWithImpl(
      this._value, this._then);

  final MessageAuthenticationInformationSubEntityModel _value;
  // ignore: unused_field
  final $Res Function(MessageAuthenticationInformationSubEntityModel) _then;

  @override
  $Res call({
    Object? businessReference = freezed,
    Object? subAccountUID = freezed,
    Object? accountUID = freezed,
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      businessReference: businessReference == freezed
          ? _value.businessReference
          : businessReference // ignore: cast_nullable_to_non_nullable
              as MessageEntityReferenceModel?,
      subAccountUID: subAccountUID == freezed
          ? _value.subAccountUID
          : subAccountUID // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $MessageEntityReferenceModelCopyWith<$Res>? get businessReference {
    if (_value.businessReference == null) {
      return null;
    }

    return $MessageEntityReferenceModelCopyWith<$Res>(_value.businessReference!,
        (value) {
      return _then(_value.copyWith(businessReference: value));
    });
  }
}

/// @nodoc
abstract class _$$_MessageAuthenticationInformationSubEntityModelCopyWith<$Res>
    implements $MessageAuthenticationInformationSubEntityModelCopyWith<$Res> {
  factory _$$_MessageAuthenticationInformationSubEntityModelCopyWith(
          _$_MessageAuthenticationInformationSubEntityModel value,
          $Res Function(_$_MessageAuthenticationInformationSubEntityModel)
              then) =
      __$$_MessageAuthenticationInformationSubEntityModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {MessageEntityReferenceModel? businessReference,
      String subAccountUID,
      String accountUID,
      String uid,
      String displayName,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          DateTime? updatedAt});

  @override
  $MessageEntityReferenceModelCopyWith<$Res>? get businessReference;
}

/// @nodoc
class __$$_MessageAuthenticationInformationSubEntityModelCopyWithImpl<$Res>
    extends _$MessageAuthenticationInformationSubEntityModelCopyWithImpl<$Res>
    implements
        _$$_MessageAuthenticationInformationSubEntityModelCopyWith<$Res> {
  __$$_MessageAuthenticationInformationSubEntityModelCopyWithImpl(
      _$_MessageAuthenticationInformationSubEntityModel _value,
      $Res Function(_$_MessageAuthenticationInformationSubEntityModel) _then)
      : super(
            _value,
            (v) =>
                _then(v as _$_MessageAuthenticationInformationSubEntityModel));

  @override
  _$_MessageAuthenticationInformationSubEntityModel get _value =>
      super._value as _$_MessageAuthenticationInformationSubEntityModel;

  @override
  $Res call({
    Object? businessReference = freezed,
    Object? subAccountUID = freezed,
    Object? accountUID = freezed,
    Object? uid = freezed,
    Object? displayName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_MessageAuthenticationInformationSubEntityModel(
      businessReference: businessReference == freezed
          ? _value.businessReference
          : businessReference // ignore: cast_nullable_to_non_nullable
              as MessageEntityReferenceModel?,
      subAccountUID: subAccountUID == freezed
          ? _value.subAccountUID
          : subAccountUID // ignore: cast_nullable_to_non_nullable
              as String,
      accountUID: accountUID == freezed
          ? _value.accountUID
          : accountUID // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageAuthenticationInformationSubEntityModel
    extends _MessageAuthenticationInformationSubEntityModel {
  const _$_MessageAuthenticationInformationSubEntityModel(
      {this.businessReference,
      this.subAccountUID = "",
      this.accountUID = "",
      this.uid = "",
      this.displayName = "",
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          this.createdAt,
      @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
          this.updatedAt})
      : super._();

  factory _$_MessageAuthenticationInformationSubEntityModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_MessageAuthenticationInformationSubEntityModelFromJson(json);

  @override
  final MessageEntityReferenceModel? businessReference;
  @override
  @JsonKey()
  final String subAccountUID;
  @override
  @JsonKey()
  final String accountUID;
  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'MessageAuthenticationInformationSubEntityModel(businessReference: $businessReference, subAccountUID: $subAccountUID, accountUID: $accountUID, uid: $uid, displayName: $displayName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageAuthenticationInformationSubEntityModel &&
            const DeepCollectionEquality()
                .equals(other.businessReference, businessReference) &&
            const DeepCollectionEquality()
                .equals(other.subAccountUID, subAccountUID) &&
            const DeepCollectionEquality()
                .equals(other.accountUID, accountUID) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(businessReference),
      const DeepCollectionEquality().hash(subAccountUID),
      const DeepCollectionEquality().hash(accountUID),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_MessageAuthenticationInformationSubEntityModelCopyWith<
          _$_MessageAuthenticationInformationSubEntityModel>
      get copyWith =>
          __$$_MessageAuthenticationInformationSubEntityModelCopyWithImpl<
                  _$_MessageAuthenticationInformationSubEntityModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageAuthenticationInformationSubEntityModelToJson(this);
  }
}

abstract class _MessageAuthenticationInformationSubEntityModel
    extends MessageAuthenticationInformationSubEntityModel {
  const factory _MessageAuthenticationInformationSubEntityModel(
          {final MessageEntityReferenceModel? businessReference,
          final String subAccountUID,
          final String accountUID,
          final String uid,
          final String displayName,
          @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
              final DateTime? createdAt,
          @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
              final DateTime? updatedAt}) =
      _$_MessageAuthenticationInformationSubEntityModel;
  const _MessageAuthenticationInformationSubEntityModel._() : super._();

  factory _MessageAuthenticationInformationSubEntityModel.fromJson(
          Map<String, dynamic> json) =
      _$_MessageAuthenticationInformationSubEntityModel.fromJson;

  @override
  MessageEntityReferenceModel? get businessReference =>
      throw _privateConstructorUsedError;
  @override
  String get subAccountUID => throw _privateConstructorUsedError;
  @override
  String get accountUID => throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "updatedAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageAuthenticationInformationSubEntityModelCopyWith<
          _$_MessageAuthenticationInformationSubEntityModel>
      get copyWith => throw _privateConstructorUsedError;
}
