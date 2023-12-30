import 'package:json_annotation/json_annotation.dart';

part 'author_key_result.g.dart';

@JsonSerializable()
class AuthorKeyResult {
  final String key;

  AuthorKeyResult({required this.key});

  factory AuthorKeyResult.fromJson(Map<String, dynamic> json) =>
      _$AuthorKeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorKeyResultToJson(this);
}
