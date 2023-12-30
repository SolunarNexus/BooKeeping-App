import 'package:book_keeping/web_api/model/edition_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edition_list_result.g.dart';

@JsonSerializable()
class EditionListResult {
  final List<EditionResult> docs;

  EditionListResult({required this.docs});

  factory EditionListResult.fromJson(Map<String, dynamic> json) =>
      _$EditionListResultFromJson(json);

  Map<String, dynamic> toJson() => _$EditionListResultToJson(this);
}
