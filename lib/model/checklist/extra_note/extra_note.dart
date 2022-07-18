import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/extra_note/extra_note_config/extra_note_config.dart';

part 'extra_note.freezed.dart';

part 'extra_note.g.dart';

@freezed
class ExtraNote with _$ExtraNote {
  const ExtraNote._();

  @JsonSerializable(explicitToJson: true)
  const factory ExtraNote({
    required String uid,
    @Default("") String name,
    @Default("") String description,
    @Default("") String text,
    @Default("") String style,
    @Default(<ExtraNoteConfig>[]) List<ExtraNoteConfig> config,
  }) = _ExtraNote;

  factory ExtraNote.fromJson(Map<String, dynamic> json) => _$ExtraNoteFromJson(json);

  String get getDisplayName {
    String result = '';
    for (var configItem in config) {
      if (configItem.displayName != "") result = configItem.displayName;
    }

    return result;
  }

  String get getDescription {
    String result = '';
    for (var configItem in config) {
      if (configItem.description != "") result = configItem.description;
    }

    return result;
  }

  String get className {
    String result = '';
    for (var configItem in config) {
      if (configItem.classObject != null) if (configItem.classObject != '') result = configItem.classObject;
    }
    return result;
  }
}
