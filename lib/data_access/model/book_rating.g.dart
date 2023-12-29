// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookRating _$BookRatingFromJson(Map<String, dynamic> json) => BookRating(
      id: json['id'] as String?,
      rating: json['rating'] as int,
      userId: json['userId'] as String,
      bookId: json['bookId'] as String,
    );

Map<String, dynamic> _$BookRatingToJson(BookRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'userId': instance.userId,
      'bookId': instance.bookId,
    };
