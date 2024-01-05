import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation extends Entity {
  final String senderUserId;
  final String receiverUserId;
  final String bookId;

  Recommendation(
      {super.id,
      required this.senderUserId,
      required this.receiverUserId,
      required this.bookId});

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recommendation &&
          runtimeType == other.runtimeType &&
          senderUserId == other.senderUserId &&
          receiverUserId == other.receiverUserId &&
          bookId == other.bookId;

  @override
  int get hashCode =>
      senderUserId.hashCode ^ receiverUserId.hashCode ^ bookId.hashCode;
}
