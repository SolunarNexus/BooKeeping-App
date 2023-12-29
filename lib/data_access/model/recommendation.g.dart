// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      id: json['id'] as String?,
      senderUserId: json['senderUserId'] as String,
      receiverUserId: json['receiverUserId'] as String,
      bookId: json['bookId'] as String,
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUserId': instance.senderUserId,
      'receiverUserId': instance.receiverUserId,
      'bookId': instance.bookId,
    };
