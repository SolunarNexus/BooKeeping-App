import 'package:book_keeping/web_api/model/key_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edition_list_result.g.dart';

@JsonSerializable()
class EditionListResult {
  final List<KeyResult> docs;

  EditionListResult({required this.docs});

  factory EditionListResult.fromJson(Map<String, dynamic> json) =>
      _$EditionListResultFromJson(json);

  Map<String, dynamic> toJson() => _$EditionListResultToJson(this);
}
