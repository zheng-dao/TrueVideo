import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_config.freezed.dart';
part 'section_config.g.dart';

@freezed
class SectionConfig with _$SectionConfig {
  factory SectionConfig({
    @Default("") String name,
    @Default("") String description,
    @Default("") String customName,
    @Default("") String type,
    int? inputOrder,
    int? outputOrder,
    @Default(true) bool isPrintable,
    @Default("") visibleFor,
  }) = _SectionConfig;

  factory SectionConfig.fromJson(Map<String, dynamic> json) => _$SectionConfigFromJson(json);
}
