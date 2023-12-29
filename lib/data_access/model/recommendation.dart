import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation {
  final String? id;
  final String senderUserId;
  final String receiverUserId;
  final String bookId;

  Recommendation(
      {this.id,
      required this.senderUserId,
      required this.receiverUserId,
      required this.bookId});

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}
