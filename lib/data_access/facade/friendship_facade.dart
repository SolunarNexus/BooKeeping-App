import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:get_it/get_it.dart';

class FriendshipFacade extends BaseFacade {
  final _friendshipService = GetIt.instance.get<FriendshipService>();

  /// returns stream of friendships where current user equals to either userId or otherUserId fields, not filtered by state
  Future<Stream<List<Friendship>>> getFriendshipStream() async {
    final currentUser = await getCurrentUser();
    return _friendshipService.getStream(currentUser.id!);
  }

  /// creates friendship with sent state with specified otherUserId
  Future<void> sendRequest(String otherUserId) async {
    final currentUser = await getCurrentUser();
    _friendshipService.create(currentUser.id!, otherUserId);
  }

  /// updates friendship specified by friendshipId, with the new state
  Future<void> acceptRequest(String friendshipId, FriendshipState newState) =>
      _friendshipService.updateState(friendshipId, newState);

  /// deletes friendship
  Future<void> deleteFriend(String friendshipId) async {
    await _friendshipService.deleteById(friendshipId);
  }
}
