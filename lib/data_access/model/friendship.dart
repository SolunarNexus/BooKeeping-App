import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friendship.g.dart';

@JsonSerializable()
class Friendship extends Entity {
  final String userId;
  final String otherUserId;
  final FriendshipState state;

  Friendship(
      {super.id,
      required this.userId,
      required this.otherUserId,
      required this.state});

  factory Friendship.fromJson(Map<String, dynamic> json) =>
      _$FriendshipFromJson(json);

  Map<String, dynamic> toJson() => _$FriendshipToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Friendship &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          otherUserId == other.otherUserId;

  @override
  int get hashCode => userId.hashCode ^ otherUserId.hashCode;

  Friendship copyWith({
    String? userId,
    String? otherUserId,
    FriendshipState? state,
  }) {
    return Friendship(
      userId: userId ?? this.userId,
      otherUserId: otherUserId ?? this.otherUserId,
      state: state ?? this.state,
    );
  }
}
