import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:get_it/get_it.dart';

class FriendshipFacade {
  final _friendshipService = GetIt.instance.get<FriendshipService>();

  Stream<List<Friendship>> getFriendshipStream(String userId) =>
      _friendshipService.getStream(userId);

  Future<void> sendRequest(String myUserId, String otherUserId) =>
      _friendshipService.create(myUserId, otherUserId);

  Future<void> acceptRequest(String friendshipId, FriendshipState newState) =>
      _friendshipService.updateState(friendshipId, newState);

  Future<void> deleteFriend(String friendshipId) async {
    await _friendshipService.deleteById(friendshipId);
  }
}
