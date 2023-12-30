import 'package:book_keeping/web_api/model/edition_list_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_result.g.dart';

@JsonSerializable()
class WorkResult {
  final String title;
  @JsonKey(name: "author_name")
  final List<String>? authorName;
  final EditionListResult editions;

  WorkResult(
      {required this.title, required this.authorName, required this.editions});

  factory WorkResult.fromJson(Map<String, dynamic> json) =>
      _$WorkResultFromJson(json);

  Map<String, dynamic> toJson() => _$WorkResultToJson(this);
}
