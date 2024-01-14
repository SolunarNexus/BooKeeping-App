import 'package:json_annotation/json_annotation.dart';

part 'value_result.g.dart';

@JsonSerializable()
class ValueResult {
  final String value;

  ValueResult({required this.value});

  factory ValueResult.fromJson(Map<String, dynamic> json) =>
      _$ValueResultFromJson(json);

  Map<String, dynamic> toJson() => _$ValueResultToJson(this);
}
