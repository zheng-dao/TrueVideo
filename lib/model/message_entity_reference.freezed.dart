// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_entity_reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageEntityReferenceModel _$MessageEntityReferenceModelFromJson(
    Map<String, dynamic> json) {
  return _MessageEntityReferenceModel.fromJson(json);
}

/// @nodoc
mixin _$MessageEntityReferenceModel {
  bool get external => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String get entityUID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageEntityReferenceModelCopyWith<MessageEntityReferenceModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityReferenceModelCopyWith<$Res> {
  factory $MessageEntityReferenceModelCopyWith(
          MessageEntityReferenceModel value,
          $Res Function(MessageEntityReferenceModel) then) =
      _$MessageEntityReferenceModelCopyWithImpl<$Res>;
  $Res call({bool external, String entityType, String entityUID});
}

/// @nodoc
class _$MessageEntityReferenceModelCopyWithImpl<$Res>
    implements $MessageEntityReferenceModelCopyWith<$Res> {
  _$MessageEntityReferenceModelCopyWithImpl(this._value, this._then);

  final MessageEntityReferenceModel _value;
  // ignore: unused_field
  final $Res Function(MessageEntityReferenceModel) _then;

  @override
  $Res call({
    Object? external = freezed,
    Object? entityType = freezed,
    Object? entityUID = freezed,
  }) {
    return _then(_value.copyWith(
      external: external == freezed
          ? _value.external
          : external // ignore: cast_nullable_to_non_nullable
              as bool,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityUID: entityUID == freezed
          ? _value.entityUID
          : entityUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageEntityReferenceModelCopyWith<$Res>
    implements $MessageEntityReferenceModelCopyWith<$Res> {
  factory _$$_MessageEntityReferenceModelCopyWith(
          _$_MessageEntityReferenceModel value,
          $Res Function(_$_MessageEntityReferenceModel) then) =
      __$$_MessageEntityReferenceModelCopyWithImpl<$Res>;
  @override
  $Res call({bool external, String entityType, String entityUID});
}

/// @nodoc
class __$$_MessageEntityReferenceModelCopyWithImpl<$Res>
    extends _$MessageEntityReferenceModelCopyWithImpl<$Res>
    implements _$$_MessageEntityReferenceModelCopyWith<$Res> {
  __$$_MessageEntityReferenceModelCopyWithImpl(
      _$_MessageEntityReferenceModel _value,
      $Res Function(_$_MessageEntityReferenceModel) _then)
      : super(_value, (v) => _then(v as _$_MessageEntityReferenceModel));

  @override
  _$_MessageEntityReferenceModel get _value =>
      super._value as _$_MessageEntityReferenceModel;

  @override
  $Res call({
    Object? external = freezed,
    Object? entityType = freezed,
    Object? entityUID = freezed,
  }) {
    return _then(_$_MessageEntityReferenceModel(
      external: external == freezed
          ? _value.external
          : external // ignore: cast_nullable_to_non_nullable
              as bool,
      entityType: entityType == freezed
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityUID: entityUID == freezed
          ? _value.entityUID
          : entityUID // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageEntityReferenceModel extends _MessageEntityReferenceModel {
  const _$_MessageEntityReferenceModel(
      {this.external = false, this.entityType = "", this.entityUID = ""})
      : super._();

  factory _$_MessageEntityReferenceModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageEntityReferenceModelFromJson(json);

  @override
  @JsonKey()
  final bool external;
  @override
  @JsonKey()
  final String entityType;
  @override
  @JsonKey()
  final String entityUID;

  @override
  String toString() {
    return 'MessageEntityReferenceModel(external: $external, entityType: $entityType, entityUID: $entityUID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageEntityReferenceModel &&
            const DeepCollectionEquality().equals(other.external, external) &&
            const DeepCollectionEquality()
                .equals(other.entityType, entityType) &&
            const DeepCollectionEquality().equals(other.entityUID, entityUID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(external),
      const DeepCollectionEquality().hash(entityType),
      const DeepCollectionEquality().hash(entityUID));

  @JsonKey(ignore: true)
  @override
  _$$_MessageEntityReferenceModelCopyWith<_$_MessageEntityReferenceModel>
      get copyWith => __$$_MessageEntityReferenceModelCopyWithImpl<
          _$_MessageEntityReferenceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageEntityReferenceModelToJson(this);
  }
}

abstract class _MessageEntityReferenceModel
    extends MessageEntityReferenceModel {
  const factory _MessageEntityReferenceModel(
      {final bool external,
      final String entityType,
      final String entityUID}) = _$_MessageEntityReferenceModel;
  const _MessageEntityReferenceModel._() : super._();

  factory _MessageEntityReferenceModel.fromJson(Map<String, dynamic> json) =
      _$_MessageEntityReferenceModel.fromJson;

  @override
  bool get external => throw _privateConstructorUsedError;
  @override
  String get entityType => throw _privateConstructorUsedError;
  @override
  String get entityUID => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageEntityReferenceModelCopyWith<_$_MessageEntityReferenceModel>
      get copyWith => throw _privateConstructorUsedError;
}
