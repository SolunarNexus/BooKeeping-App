import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  final String? id;
  final String userId;
  final String otherUserId;

  Friend({this.id, required this.userId, required this.otherUserId});

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
