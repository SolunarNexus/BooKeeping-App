import 'package:book_keeping/web_api/model/key_result.dart';
import 'package:book_keeping/web_api/model/value_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_result.g.dart';

@JsonSerializable()
class BookResult {
  final List<String>? publishers;
  @JsonKey(fromJson: _deserializeDesc)
  final String? description;
  final List<KeyResult>? authors;
  @JsonKey(name: "publish_date")
  final String? publishDate;
  @JsonKey(name: "number_of_pages")
  final int? numberOfPages;
  final List<KeyResult>? languages;
  final List<String>? subjects;
  @JsonKey(name: "isbn_10")
  final List<String>? isbn;

  BookResult(
      {required this.publishers,
      required this.description,
      required this.authors,
      required this.publishDate,
      required this.numberOfPages,
      required this.languages,
      required this.subjects,
      required this.isbn});

  factory BookResult.fromJson(Map<String, dynamic> json) =>
      _$BookResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookResultToJson(this);

  static String? _deserializeDesc(dynamic json) {
    if (json is String) {
      return json;
    } else if (json is Map<String, dynamic>) {
      return ValueResult.fromJson(json).value;
    }
    return null;
  }
}
