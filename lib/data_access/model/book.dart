import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book extends Entity {
  final String title;
  final String? description;
  final List<String> authors;
  final String imgUrl;
  final String publishDate;
  final List<String> publishers;
  final int? pages;
  final List<String> languages;
  final List<String> categories;
  final String isbn;

  Book(
      {super.id,
      required this.description,
      required this.imgUrl,
      required this.publishDate,
      required this.publishers,
      required this.pages,
      required this.languages,
      required this.categories,
      required this.isbn,
      required this.title,
      required this.authors});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Book && runtimeType == other.runtimeType && isbn == other.isbn;

  @override
  int get hashCode => isbn.hashCode;
}
