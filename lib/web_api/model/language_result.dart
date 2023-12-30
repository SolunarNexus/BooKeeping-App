import 'package:json_annotation/json_annotation.dart';

part 'language_result.g.dart';

@JsonSerializable()
class LanguageResult {
  final String key;

  LanguageResult({required this.key});

  factory LanguageResult.fromJson(Map<String, dynamic> json) =>
      _$LanguageResultFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageResultToJson(this);
}
