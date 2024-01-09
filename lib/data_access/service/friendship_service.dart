import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:get_it/get_it.dart';

class FriendshipService extends BaseFirestoreService<Friendship> {
  FriendshipService()
      : super(
            collectionType: CollectionType.friendship,
            fromJson: Friendship.fromJson,
            toJson: _toJson,
            equals: _equals);

  Future<Friendship?> getByEmail(String email) async {
    final user = await GetIt.instance.get<UserService>().getByEmail(email);
    final currentUser =
        await GetIt.instance.get<FriendshipFacade>().getCurrentUser().first;

    return (await getAll().first).where((friendship) {
      return user!.id != currentUser.id &&
          (friendship.userId == user.id || friendship.otherUserId == user.id);
    }).firstOrNull;
  }

  Stream<List<Friendship>> getAllByUserId(String userId) =>
      getAll().map((friendshipList) => friendshipList
          .where((friendship) =>
              friendship.userId == userId || friendship.otherUserId == userId)
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
            friendship.userId == userId &&
            friendship.otherUserId == otherUserId)
        .single;
  }

  Future<Friendship?> find(String firstUserId, String secondUserId) async {
    if (await exists(Friendship(
        userId: firstUserId,
        otherUserId: secondUserId,
        state: FriendshipState.sent))) {
      return await getByIds(firstUserId, secondUserId);
    } else if (await exists(Friendship(
        userId: secondUserId,
        otherUserId: firstUserId,
        state: FriendshipState.sent))) {
      return await getByIds(secondUserId, firstUserId);
    }
    return null;
  }

  static Map<String, dynamic> _toJson(Friendship friendship) =>
      friendship.toJson();

  static bool _equals(Friendship first, Friendship second) => first == second;
}
