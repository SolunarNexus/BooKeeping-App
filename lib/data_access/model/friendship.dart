import 'package:json_annotation/json_annotation.dart';

part 'friendship.g.dart';

@JsonSerializable()
class Friendship {
  final String? id;
  final String userId;
  final String otherUserId;

  Friendship({this.id, required this.userId, required this.otherUserId});

  factory Friendship.fromJson(Map<String, dynamic> json) =>
      _$FriendshipFromJson(json);

  Map<String, dynamic> toJson() => _$FriendshipToJson(this);
}
