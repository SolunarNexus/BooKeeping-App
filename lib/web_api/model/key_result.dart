import 'package:json_annotation/json_annotation.dart';

part 'key_result.g.dart';

@JsonSerializable()
class KeyResult {
  final String key;

  KeyResult({required this.key});

  factory KeyResult.fromJson(Map<String, dynamic> json) =>
      _$KeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$KeyResultToJson(this);
}
