import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation {
  final String? id;
  final String friendshipId;
  final String bookId;

  Recommendation({this.id, required this.friendshipId, required this.bookId});

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}
