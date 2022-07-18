import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:truvideo_enterprise/model/checklist/section/section.dart';

part 'definitions.freezed.dart';
part 'definitions.g.dart';

@freezed
class Definitions with _$Definitions {
  factory Definitions({@Default(<Section>[]) List<Section> sections}) = _Definitions;

  factory Definitions.fromJson(Map<String, dynamic> json) => _$DefinitionsFromJson(json);
}
