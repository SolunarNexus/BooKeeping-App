import 'package:json_annotation/json_annotation.dart';

part 'edition_result.g.dart';

@JsonSerializable()
class EditionResult {
  final String key;

  EditionResult({required this.key});

  factory EditionResult.fromJson(Map<String, dynamic> json) =>
      _$EditionResultFromJson(json);

  Map<String, dynamic> toJson() => _$EditionResultToJson(this);
}
