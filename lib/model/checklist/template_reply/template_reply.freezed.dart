// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'template_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TemplateReply _$TemplateReplyFromJson(Map<String, dynamic> json) {
  return _TemplateReply.fromJson(json);
}

/// @nodoc
mixin _$TemplateReply {
  ReplyForm get reply => throw _privateConstructorUsedError;
  Template get template => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TemplateReplyCopyWith<TemplateReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateReplyCopyWith<$Res> {
  factory $TemplateReplyCopyWith(
          TemplateReply value, $Res Function(TemplateReply) then) =
      _$TemplateReplyCopyWithImpl<$Res>;
  $Res call({ReplyForm reply, Template template});

  $ReplyFormCopyWith<$Res> get reply;
  $TemplateCopyWith<$Res> get template;
}

/// @nodoc
class _$TemplateReplyCopyWithImpl<$Res>
    implements $TemplateReplyCopyWith<$Res> {
  _$TemplateReplyCopyWithImpl(this._value, this._then);

  final TemplateReply _value;
  // ignore: unused_field
  final $Res Function(TemplateReply) _then;

  @override
  $Res call({
    Object? reply = freezed,
    Object? template = freezed,
  }) {
    return _then(_value.copyWith(
      reply: reply == freezed
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReplyForm,
      template: template == freezed
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as Template,
    ));
  }

  @override
  $ReplyFormCopyWith<$Res> get reply {
    return $ReplyFormCopyWith<$Res>(_value.reply, (value) {
      return _then(_value.copyWith(reply: value));
    });
  }

  @override
  $TemplateCopyWith<$Res> get template {
    return $TemplateCopyWith<$Res>(_value.template, (value) {
      return _then(_value.copyWith(template: value));
    });
  }
}

/// @nodoc
abstract class _$$_TemplateReplyCopyWith<$Res>
    implements $TemplateReplyCopyWith<$Res> {
  factory _$$_TemplateReplyCopyWith(
          _$_TemplateReply value, $Res Function(_$_TemplateReply) then) =
      __$$_TemplateReplyCopyWithImpl<$Res>;
  @override
  $Res call({ReplyForm reply, Template template});

  @override
  $ReplyFormCopyWith<$Res> get reply;
  @override
  $TemplateCopyWith<$Res> get template;
}

/// @nodoc
class __$$_TemplateReplyCopyWithImpl<$Res>
    extends _$TemplateReplyCopyWithImpl<$Res>
    implements _$$_TemplateReplyCopyWith<$Res> {
  __$$_TemplateReplyCopyWithImpl(
      _$_TemplateReply _value, $Res Function(_$_TemplateReply) _then)
      : super(_value, (v) => _then(v as _$_TemplateReply));

  @override
  _$_TemplateReply get _value => super._value as _$_TemplateReply;

  @override
  $Res call({
    Object? reply = freezed,
    Object? template = freezed,
  }) {
    return _then(_$_TemplateReply(
      reply: reply == freezed
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as ReplyForm,
      template: template == freezed
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as Template,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TemplateReply implements _TemplateReply {
  _$_TemplateReply({required this.reply, required this.template});

  factory _$_TemplateReply.fromJson(Map<String, dynamic> json) =>
      _$$_TemplateReplyFromJson(json);

  @override
  final ReplyForm reply;
  @override
  final Template template;

  @override
  String toString() {
    return 'TemplateReply(reply: $reply, template: $template)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TemplateReply &&
            const DeepCollectionEquality().equals(other.reply, reply) &&
            const DeepCollectionEquality().equals(other.template, template));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(reply),
      const DeepCollectionEquality().hash(template));

  @JsonKey(ignore: true)
  @override
  _$$_TemplateReplyCopyWith<_$_TemplateReply> get copyWith =>
      __$$_TemplateReplyCopyWithImpl<_$_TemplateReply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TemplateReplyToJson(this);
  }
}

abstract class _TemplateReply implements TemplateReply {
  factory _TemplateReply(
      {required final ReplyForm reply,
      required final Template template}) = _$_TemplateReply;

  factory _TemplateReply.fromJson(Map<String, dynamic> json) =
      _$_TemplateReply.fromJson;

  @override
  ReplyForm get reply => throw _privateConstructorUsedError;
  @override
  Template get template => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TemplateReplyCopyWith<_$_TemplateReply> get copyWith =>
      throw _privateConstructorUsedError;
}
