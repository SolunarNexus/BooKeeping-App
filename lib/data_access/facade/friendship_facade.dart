import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:get_it/get_it.dart';

class FriendshipFacade extends BaseFacade {
  final _friendshipService = GetIt.instance.get<FriendshipService>();
  final _converterService = GetIt.instance.get<ConverterService>();

  /// returns stream of friendships where current user equals to either userId or otherUserId fields, not filtered by state
  Future<Stream<List<FriendshipComplete>>> getFriendshipStream() async {
    final currentUser = await getCurrentUser();
    return _friendshipService.getAllByUserId(currentUser.id!).asyncMap(
        (friendships) => Stream.fromIterable(friendships)
            .asyncMap(
                (friendship) => _converterService.fromFriendship(friendship))
            .toList());
  }

  /// creates friendship with sent state with specified otherUserId
  Future<void> sendRequest(String otherUserId) async {
    final currentUser = await getCurrentUser();
    _friendshipService.create(Friendship(
        userId: currentUser.id!,
        otherUserId: otherUserId,
        state: FriendshipState.sent));
  }

  /// accepts friendship specified by friendshipId
  Future<void> acceptRequest(String friendshipId) =>
      _friendshipService.updateState(friendshipId, FriendshipState.accepted);

  /// deletes friendship
  Future<void> deleteFriend(String friendshipId) async {
    await _friendshipService.remove(friendshipId);
  }
}
