import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friendship.g.dart';

@JsonSerializable()
class Friendship extends Entity {
  final String senderId;
  final String receiverId;
  final FriendshipState state;

  Friendship(
      {super.id,
      required this.senderId,
      required this.receiverId,
      required this.state});

  factory Friendship.fromJson(Map<String, dynamic> json) =>
      _$FriendshipFromJson(json);

  Map<String, dynamic> toJson() => _$FriendshipToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Friendship &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          receiverId == other.receiverId;

  @override
  int get hashCode => senderId.hashCode ^ receiverId.hashCode;

  Friendship copyWith({
    String? id,
    String? userId,
    String? otherUserId,
    FriendshipState? state,
  }) {
    return Friendship(
      id: id ?? this.id,
      senderId: userId ?? senderId,
      receiverId: otherUserId ?? receiverId,
      state: state ?? this.state,
    );
  }
}
