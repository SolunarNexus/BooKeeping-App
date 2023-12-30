import 'package:json_annotation/json_annotation.dart';

part 'author_result.g.dart';

@JsonSerializable()
class AuthorResult {
  final String key;
  final String name;

  AuthorResult({required this.key, required this.name});

  factory AuthorResult.fromJson(Map<String, dynamic> json) =>
      _$AuthorResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorResultToJson(this);
}
