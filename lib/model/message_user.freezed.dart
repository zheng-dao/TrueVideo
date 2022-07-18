// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageUserModel _$MessageUserModelFromJson(Map<String, dynamic> json) {
  return _MessageUserModel.fromJson(json);
}

/// @nodoc
mixin _$MessageUserModel {
  String get uid => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageUserModelCopyWith<MessageUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageUserModelCopyWith<$Res> {
  factory $MessageUserModelCopyWith(
          MessageUserModel value, $Res Function(MessageUserModel) then) =
      _$MessageUserModelCopyWithImpl<$Res>;
  $Res call({String uid, String displayName});
}

/// @nodoc
class _$MessageUserModelCopyWithImpl<$Res>
    implements $MessageUserModelCopyWith<$Res> {
  _$MessageUserModelCopyWithImpl(this._value, this._then);

  final MessageUserModel _value;
  // ignore: unused_field
  final $Res Function(MessageUserModel) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageUserModelCopyWith<$Res>
    implements $MessageUserModelCopyWith<$Res> {
  factory _$$_MessageUserModelCopyWith(
          _$_MessageUserModel value, $Res Function(_$_MessageUserModel) then) =
      __$$_MessageUserModelCopyWithImpl<$Res>;
  @override
  $Res call({String uid, String displayName});
}

/// @nodoc
class __$$_MessageUserModelCopyWithImpl<$Res>
    extends _$MessageUserModelCopyWithImpl<$Res>
    implements _$$_MessageUserModelCopyWith<$Res> {
  __$$_MessageUserModelCopyWithImpl(
      _$_MessageUserModel _value, $Res Function(_$_MessageUserModel) _then)
      : super(_value, (v) => _then(v as _$_MessageUserModel));

  @override
  _$_MessageUserModel get _value => super._value as _$_MessageUserModel;

  @override
  $Res call({
    Object? uid = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_$_MessageUserModel(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_MessageUserModel extends _MessageUserModel {
  const _$_MessageUserModel({this.uid = "", this.displayName = ""}) : super._();

  factory _$_MessageUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessageUserModelFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String displayName;

  @override
  String toString() {
    return 'MessageUserModel(uid: $uid, displayName: $displayName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageUserModel &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(displayName));

  @JsonKey(ignore: true)
  @override
  _$$_MessageUserModelCopyWith<_$_MessageUserModel> get copyWith =>
      __$$_MessageUserModelCopyWithImpl<_$_MessageUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageUserModelToJson(this);
  }
}

abstract class _MessageUserModel extends MessageUserModel {
  const factory _MessageUserModel(
      {final String uid, final String displayName}) = _$_MessageUserModel;
  const _MessageUserModel._() : super._();

  factory _MessageUserModel.fromJson(Map<String, dynamic> json) =
      _$_MessageUserModel.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageUserModelCopyWith<_$_MessageUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
