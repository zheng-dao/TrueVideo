// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoTagModel _$VideoTagModelFromJson(Map<String, dynamic> json) {
  return _VideoTagModel.fromJson(json);
}

/// @nodoc
mixin _$VideoTagModel {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoTagModelCopyWith<VideoTagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoTagModelCopyWith<$Res> {
  factory $VideoTagModelCopyWith(
          VideoTagModel value, $Res Function(VideoTagModel) then) =
      _$VideoTagModelCopyWithImpl<$Res>;
  $Res call({String key, String value, String displayName, String type});
}

/// @nodoc
class _$VideoTagModelCopyWithImpl<$Res>
    implements $VideoTagModelCopyWith<$Res> {
  _$VideoTagModelCopyWithImpl(this._value, this._then);

  final VideoTagModel _value;
  // ignore: unused_field
  final $Res Function(VideoTagModel) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoTagModelCopyWith<$Res>
    implements $VideoTagModelCopyWith<$Res> {
  factory _$$_VideoTagModelCopyWith(
          _$_VideoTagModel value, $Res Function(_$_VideoTagModel) then) =
      __$$_VideoTagModelCopyWithImpl<$Res>;
  @override
  $Res call({String key, String value, String displayName, String type});
}

/// @nodoc
class __$$_VideoTagModelCopyWithImpl<$Res>
    extends _$VideoTagModelCopyWithImpl<$Res>
    implements _$$_VideoTagModelCopyWith<$Res> {
  __$$_VideoTagModelCopyWithImpl(
      _$_VideoTagModel _value, $Res Function(_$_VideoTagModel) _then)
      : super(_value, (v) => _then(v as _$_VideoTagModel));

  @override
  _$_VideoTagModel get _value => super._value as _$_VideoTagModel;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_VideoTagModel(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VideoTagModel implements _VideoTagModel {
  _$_VideoTagModel(
      {this.key = '', this.value = '', this.displayName = '', this.type = ''});

  factory _$_VideoTagModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoTagModelFromJson(json);

  @override
  @JsonKey()
  final String key;
  @override
  @JsonKey()
  final String value;
  @override
  @JsonKey()
  final String displayName;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'VideoTagModel(key: $key, value: $value, displayName: $displayName, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoTagModel &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$_VideoTagModelCopyWith<_$_VideoTagModel> get copyWith =>
      __$$_VideoTagModelCopyWithImpl<_$_VideoTagModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoTagModelToJson(this);
  }
}

abstract class _VideoTagModel implements VideoTagModel {
  factory _VideoTagModel(
      {final String key,
      final String value,
      final String displayName,
      final String type}) = _$_VideoTagModel;

  factory _VideoTagModel.fromJson(Map<String, dynamic> json) =
      _$_VideoTagModel.fromJson;

  @override
  String get key => throw _privateConstructorUsedError;
  @override
  String get value => throw _privateConstructorUsedError;
  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoTagModelCopyWith<_$_VideoTagModel> get copyWith =>
      throw _privateConstructorUsedError;
}
