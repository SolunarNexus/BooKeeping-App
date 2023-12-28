import 'package:json_annotation/json_annotation.dart';

part 'book_rating.g.dart';

@JsonSerializable()
class BookRating {
  final String? id;
  final int rating;
  final String userId;
  final String bookId;

  BookRating(
      {this.id,
      required this.rating,
      required this.userId,
      required this.bookId});

  factory BookRating.fromJson(Map<String, dynamic> json) =>
      _$BookRatingFromJson(json);

  Map<String, dynamic> toJson() => _$BookRatingToJson(this);
}
