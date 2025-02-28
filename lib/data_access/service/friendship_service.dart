import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class FriendshipService extends BaseFirestoreService<Friendship> {
  FriendshipService()
      : super(
            collectionType: CollectionType.friendship,
            fromJson: Friendship.fromJson,
            toJson: _toJson,
            equals: _equals);

  Stream<List<Friendship>> getAllByUserId(String userId) =>
      getAll().map((friendshipList) => friendshipList
          .where((friendship) =>
              friendship.senderId == userId || friendship.receiverId == userId)
          .toList());

  Future<void> updateState(String id, FriendshipState newState) async {
    final friendship = await getSingle(id).first;
    if (friendship == null) {
      throw Exception(
          "${CollectionType.friendship.collectionPath} with id: $id does not exist");
    }
    await update(friendship.copyWith(state: newState));
  }

  Future<Friendship> getByIds(String userId, String otherUserId) async {
    final friendships = await getAll().first;
    return friendships
        .where((friendship) =>
            friendship.senderId == userId &&
            friendship.receiverId == otherUserId)
        .single;
  }

  Future<Friendship?> find(String firstUserId, String secondUserId) async {
    if (await exists(Friendship(
        senderId: firstUserId,
        receiverId: secondUserId,
        state: FriendshipState.sent))) {
      return await getByIds(firstUserId, secondUserId);
    } else if (await exists(Friendship(
        senderId: secondUserId,
        receiverId: firstUserId,
        state: FriendshipState.sent))) {
      return await getByIds(secondUserId, firstUserId);
    }
    return null;
  }

  static Map<String, dynamic> _toJson(Friendship friendship) =>
      friendship.toJson();

  static bool _equals(Friendship first, Friendship second) => first == second;
}
