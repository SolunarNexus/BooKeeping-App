import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book extends Entity {
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
      {super.id,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book && runtimeType == other.runtimeType && isbn == other.isbn;

  @override
  int get hashCode => isbn.hashCode;
}
