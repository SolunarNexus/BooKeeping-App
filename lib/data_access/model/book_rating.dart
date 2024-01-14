import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_rating.g.dart';

@JsonSerializable()
class BookRating extends Entity {
  final double rating;
  final String userId;
  final String bookId;
  final String text;

  BookRating(
      {super.id,
      required this.rating,
      required this.userId,
      required this.bookId,
      required this.text});

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

  BookRating copyWith({
    String? id,
    double? rating,
    String? userId,
    String? bookId,
    String? text,
  }) {
    return BookRating(
      id: id ?? super.id,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      text: text ?? this.text,
    );
  }
}
