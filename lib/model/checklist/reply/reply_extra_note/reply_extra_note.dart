// main.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply_extra_note.freezed.dart';

part 'reply_extra_note.g.dart';

@freezed
class ReplyExtraNote with _$ReplyExtraNote {
  const ReplyExtraNote._();

  @JsonSerializable(explicitToJson: true)
  const factory ReplyExtraNote({
    @Default("") String optionUID,
    String? description,
  }) = _ReplyExtraNote;

  factory ReplyExtraNote.fromJson(Map<String, dynamic> json) => _$ReplyExtraNoteFromJson(json);
}
