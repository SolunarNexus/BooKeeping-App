import 'package:json_annotation/json_annotation.dart';

part 'book_result.g.dart';

@JsonSerializable()
class BookResult {
  final String title;

  BookResult({required this.title});

  factory BookResult.fromJson(Map<String, dynamic> json) =>
      _$BookResultFromJson(json);

  Map<String, dynamic> toJson() => _$BookResultToJson(this);
}
