// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'video_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoSessionModel _$VideoSessionModelFromJson(Map<String, dynamic> json) {
  return _VideoSessionModel.fromJson(json);
}

/// @nodoc
mixin _$VideoSessionModel {
  List<VideoSessionFileModel> get videos => throw _privateConstructorUsedError;
  List<VideoSessionFileModel> get pictures =>
      throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoSessionModelCopyWith<VideoSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoSessionModelCopyWith<$Res> {
  factory $VideoSessionModelCopyWith(
          VideoSessionModel value, $Res Function(VideoSessionModel) then) =
      _$VideoSessionModelCopyWithImpl<$Res>;
  $Res call(
      {List<VideoSessionFileModel> videos,
      List<VideoSessionFileModel> pictures,
      String uid,
      String tag,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt});
}

/// @nodoc
class _$VideoSessionModelCopyWithImpl<$Res>
    implements $VideoSessionModelCopyWith<$Res> {
  _$VideoSessionModelCopyWithImpl(this._value, this._then);

  final VideoSessionModel _value;
  // ignore: unused_field
  final $Res Function(VideoSessionModel) _then;

  @override
  $Res call({
    Object? videos = freezed,
    Object? pictures = freezed,
    Object? uid = freezed,
    Object? tag = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      videos: videos == freezed
          ? _value.videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<VideoSessionFileModel>,
      pictures: pictures == freezed
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<VideoSessionFileModel>,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_VideoSessionModelCopyWith<$Res>
    implements $VideoSessionModelCopyWith<$Res> {
  factory _$$_VideoSessionModelCopyWith(_$_VideoSessionModel value,
          $Res Function(_$_VideoSessionModel) then) =
      __$$_VideoSessionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<VideoSessionFileModel> videos,
      List<VideoSessionFileModel> pictures,
      String uid,
      String tag,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          DateTime? createdAt});
}

/// @nodoc
class __$$_VideoSessionModelCopyWithImpl<$Res>
    extends _$VideoSessionModelCopyWithImpl<$Res>
    implements _$$_VideoSessionModelCopyWith<$Res> {
  __$$_VideoSessionModelCopyWithImpl(
      _$_VideoSessionModel _value, $Res Function(_$_VideoSessionModel) _then)
      : super(_value, (v) => _then(v as _$_VideoSessionModel));

  @override
  _$_VideoSessionModel get _value => super._value as _$_VideoSessionModel;

  @override
  $Res call({
    Object? videos = freezed,
    Object? pictures = freezed,
    Object? uid = freezed,
    Object? tag = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_VideoSessionModel(
      videos: videos == freezed
          ? _value._videos
          : videos // ignore: cast_nullable_to_non_nullable
              as List<VideoSessionFileModel>,
      pictures: pictures == freezed
          ? _value._pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as List<VideoSessionFileModel>,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_VideoSessionModel extends _VideoSessionModel {
  const _$_VideoSessionModel(
      {final List<VideoSessionFileModel> videos =
          const <VideoSessionFileModel>[],
      final List<VideoSessionFileModel> pictures =
          const <VideoSessionFileModel>[],
      this.uid = "",
      this.tag = "",
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          this.createdAt})
      : _videos = videos,
        _pictures = pictures,
        super._();

  factory _$_VideoSessionModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoSessionModelFromJson(json);

  final List<VideoSessionFileModel> _videos;
  @override
  @JsonKey()
  List<VideoSessionFileModel> get videos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_videos);
  }

  final List<VideoSessionFileModel> _pictures;
  @override
  @JsonKey()
  List<VideoSessionFileModel> get pictures {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictures);
  }

  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String tag;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'VideoSessionModel(videos: $videos, pictures: $pictures, uid: $uid, tag: $tag, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoSessionModel &&
            const DeepCollectionEquality().equals(other._videos, _videos) &&
            const DeepCollectionEquality().equals(other._pictures, _pictures) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_videos),
      const DeepCollectionEquality().hash(_pictures),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_VideoSessionModelCopyWith<_$_VideoSessionModel> get copyWith =>
      __$$_VideoSessionModelCopyWithImpl<_$_VideoSessionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoSessionModelToJson(this);
  }
}

abstract class _VideoSessionModel extends VideoSessionModel {
  const factory _VideoSessionModel(
      {final List<VideoSessionFileModel> videos,
      final List<VideoSessionFileModel> pictures,
      final String uid,
      final String tag,
      @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
          final DateTime? createdAt}) = _$_VideoSessionModel;
  const _VideoSessionModel._() : super._();

  factory _VideoSessionModel.fromJson(Map<String, dynamic> json) =
      _$_VideoSessionModel.fromJson;

  @override
  List<VideoSessionFileModel> get videos => throw _privateConstructorUsedError;
  @override
  List<VideoSessionFileModel> get pictures =>
      throw _privateConstructorUsedError;
  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get tag => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createdAt", fromJson: DateTimeConverter.fromJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_VideoSessionModelCopyWith<_$_VideoSessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
