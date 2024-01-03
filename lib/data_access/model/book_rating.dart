import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_rating.g.dart';

@JsonSerializable()
class BookRating extends Entity {
  final int rating;
  final String userId;
  final String bookId;

  BookRating(
      {super.id,
      required this.rating,
      required this.userId,
      required this.bookId});

  factory BookRating.fromJson(Map<String, dynamic> json) =>
      _$BookRatingFromJson(json);

  Map<String, dynamic> toJson() => _$BookRatingToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookRating &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          bookId == other.bookId;

  @override
  int get hashCode => userId.hashCode ^ bookId.hashCode;
}
