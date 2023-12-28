// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      id: json['id'] as String?,
      friendshipId: json['friendshipId'] as String,
      bookId: json['bookId'] as String,
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'friendshipId': instance.friendshipId,
      'bookId': instance.bookId,
    };
