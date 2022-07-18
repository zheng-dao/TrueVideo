// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'text_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TextMessageModel _$TextMessageModelFromJson(Map<String, dynamic> json) {
  return _TextMessageModel.fromJson(json);
}

/// @nodoc
mixin _$TextMessageModel {
  int get conversationId => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  FileInfoModel? get attachment => throw _privateConstructorUsedError;
  FileAttachmentModel? get mmsAttachment => throw _privateConstructorUsedError;
  String get deliveryStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get dateTimeSent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextMessageModelCopyWith<TextMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextMessageModelCopyWith<$Res> {
  factory $TextMessageModelCopyWith(
          TextMessageModel value, $Res Function(TextMessageModel) then) =
      _$TextMessageModelCopyWithImpl<$Res>;
  $Res call(
      {int conversationId,
      String direction,
      String message,
      String from,
      String to,
      FileInfoModel? attachment,
      FileAttachmentModel? mmsAttachment,
      String deliveryStatus,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? dateTimeSent});

  $FileInfoModelCopyWith<$Res>? get attachment;
  $FileAttachmentModelCopyWith<$Res>? get mmsAttachment;
}

/// @nodoc
class _$TextMessageModelCopyWithImpl<$Res>
    implements $TextMessageModelCopyWith<$Res> {
  _$TextMessageModelCopyWithImpl(this._value, this._then);

  final TextMessageModel _value;
  // ignore: unused_field
  final $Res Function(TextMessageModel) _then;

  @override
  $Res call({
    Object? conversationId = freezed,
    Object? direction = freezed,
    Object? message = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? attachment = freezed,
    Object? mmsAttachment = freezed,
    Object? deliveryStatus = freezed,
    Object? dateTimeSent = freezed,
  }) {
    return _then(_value.copyWith(
      conversationId: conversationId == freezed
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      attachment: attachment == freezed
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as FileInfoModel?,
      mmsAttachment: mmsAttachment == freezed
          ? _value.mmsAttachment
          : mmsAttachment // ignore: cast_nullable_to_non_nullable
              as FileAttachmentModel?,
      deliveryStatus: deliveryStatus == freezed
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String,
      dateTimeSent: dateTimeSent == freezed
          ? _value.dateTimeSent
          : dateTimeSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $FileInfoModelCopyWith<$Res>? get attachment {
    if (_value.attachment == null) {
      return null;
    }

    return $FileInfoModelCopyWith<$Res>(_value.attachment!, (value) {
      return _then(_value.copyWith(attachment: value));
    });
  }

  @override
  $FileAttachmentModelCopyWith<$Res>? get mmsAttachment {
    if (_value.mmsAttachment == null) {
      return null;
    }

    return $FileAttachmentModelCopyWith<$Res>(_value.mmsAttachment!, (value) {
      return _then(_value.copyWith(mmsAttachment: value));
    });
  }
}

/// @nodoc
abstract class _$$_TextMessageModelCopyWith<$Res>
    implements $TextMessageModelCopyWith<$Res> {
  factory _$$_TextMessageModelCopyWith(
          _$_TextMessageModel value, $Res Function(_$_TextMessageModel) then) =
      __$$_TextMessageModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int conversationId,
      String direction,
      String message,
      String from,
      String to,
      FileInfoModel? attachment,
      FileAttachmentModel? mmsAttachment,
      String deliveryStatus,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          DateTime? dateTimeSent});

  @override
  $FileInfoModelCopyWith<$Res>? get attachment;
  @override
  $FileAttachmentModelCopyWith<$Res>? get mmsAttachment;
}

/// @nodoc
class __$$_TextMessageModelCopyWithImpl<$Res>
    extends _$TextMessageModelCopyWithImpl<$Res>
    implements _$$_TextMessageModelCopyWith<$Res> {
  __$$_TextMessageModelCopyWithImpl(
      _$_TextMessageModel _value, $Res Function(_$_TextMessageModel) _then)
      : super(_value, (v) => _then(v as _$_TextMessageModel));

  @override
  _$_TextMessageModel get _value => super._value as _$_TextMessageModel;

  @override
  $Res call({
    Object? conversationId = freezed,
    Object? direction = freezed,
    Object? message = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? attachment = freezed,
    Object? mmsAttachment = freezed,
    Object? deliveryStatus = freezed,
    Object? dateTimeSent = freezed,
  }) {
    return _then(_$_TextMessageModel(
      conversationId: conversationId == freezed
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as int,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      from: from == freezed
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: to == freezed
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      attachment: attachment == freezed
          ? _value.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as FileInfoModel?,
      mmsAttachment: mmsAttachment == freezed
          ? _value.mmsAttachment
          : mmsAttachment // ignore: cast_nullable_to_non_nullable
              as FileAttachmentModel?,
      deliveryStatus: deliveryStatus == freezed
          ? _value.deliveryStatus
          : deliveryStatus // ignore: cast_nullable_to_non_nullable
              as String,
      dateTimeSent: dateTimeSent == freezed
          ? _value.dateTimeSent
          : dateTimeSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TextMessageModel extends _TextMessageModel {
  const _$_TextMessageModel(
      {this.conversationId = 0,
      this.direction = "",
      this.message = "",
      this.from = "",
      this.to = "",
      this.attachment,
      this.mmsAttachment,
      this.deliveryStatus = "",
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          this.dateTimeSent})
      : super._();

  factory _$_TextMessageModel.fromJson(Map<String, dynamic> json) =>
      _$$_TextMessageModelFromJson(json);

  @override
  @JsonKey()
  final int conversationId;
  @override
  @JsonKey()
  final String direction;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String from;
  @override
  @JsonKey()
  final String to;
  @override
  final FileInfoModel? attachment;
  @override
  final FileAttachmentModel? mmsAttachment;
  @override
  @JsonKey()
  final String deliveryStatus;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  final DateTime? dateTimeSent;

  @override
  String toString() {
    return 'TextMessageModel(conversationId: $conversationId, direction: $direction, message: $message, from: $from, to: $to, attachment: $attachment, mmsAttachment: $mmsAttachment, deliveryStatus: $deliveryStatus, dateTimeSent: $dateTimeSent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextMessageModel &&
            const DeepCollectionEquality()
                .equals(other.conversationId, conversationId) &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            const DeepCollectionEquality()
                .equals(other.attachment, attachment) &&
            const DeepCollectionEquality()
                .equals(other.mmsAttachment, mmsAttachment) &&
            const DeepCollectionEquality()
                .equals(other.deliveryStatus, deliveryStatus) &&
            const DeepCollectionEquality()
                .equals(other.dateTimeSent, dateTimeSent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(conversationId),
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      const DeepCollectionEquality().hash(attachment),
      const DeepCollectionEquality().hash(mmsAttachment),
      const DeepCollectionEquality().hash(deliveryStatus),
      const DeepCollectionEquality().hash(dateTimeSent));

  @JsonKey(ignore: true)
  @override
  _$$_TextMessageModelCopyWith<_$_TextMessageModel> get copyWith =>
      __$$_TextMessageModelCopyWithImpl<_$_TextMessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextMessageModelToJson(this);
  }
}

abstract class _TextMessageModel extends TextMessageModel {
  const factory _TextMessageModel(
      {final int conversationId,
      final String direction,
      final String message,
      final String from,
      final String to,
      final FileInfoModel? attachment,
      final FileAttachmentModel? mmsAttachment,
      final String deliveryStatus,
      @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
          final DateTime? dateTimeSent}) = _$_TextMessageModel;
  const _TextMessageModel._() : super._();

  factory _TextMessageModel.fromJson(Map<String, dynamic> json) =
      _$_TextMessageModel.fromJson;

  @override
  int get conversationId => throw _privateConstructorUsedError;
  @override
  String get direction => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  String get from => throw _privateConstructorUsedError;
  @override
  String get to => throw _privateConstructorUsedError;
  @override
  FileInfoModel? get attachment => throw _privateConstructorUsedError;
  @override
  FileAttachmentModel? get mmsAttachment => throw _privateConstructorUsedError;
  @override
  String get deliveryStatus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "createDate", fromJson: DateTimeConverter.fromJson)
  DateTime? get dateTimeSent => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TextMessageModelCopyWith<_$_TextMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
