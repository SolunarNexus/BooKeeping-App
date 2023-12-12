import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String id;
  final String title;
  final String description;
  final String author;
  final String imgUrl;
  final DateTime publishDate;
  final String publisher;
  final int pages;
  final String language;
  final List<String> categories;
  final String isbn;

  Book(
      {required this.id,
      required this.description,
      required this.imgUrl,
      required this.publishDate,
      required this.publisher,
      required this.pages,
      required this.language,
      required this.categories,
      required this.isbn,
      required this.title,
      required this.author});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
