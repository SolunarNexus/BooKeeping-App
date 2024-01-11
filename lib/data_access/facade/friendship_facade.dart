import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class FriendshipFacade extends BaseFacade {
  final _friendshipService = GetIt.instance.get<FriendshipService>();
  final _converterService = GetIt.instance.get<ConverterService>();
  final _userService = GetIt.instance.get<UserService>();

  /// returns stream of friendships where current user equals to either userId or otherUserId fields, not filtered by state
  Stream<List<FriendshipComplete>> getFriendshipStream() =>
      getCurrentUser().switchMap((user) => _friendshipService
          .getAllByUserId(user.id!)
          .asyncMap((friendships) => Stream.fromIterable(friendships)
              .asyncMap(
                  (friendship) => _converterService.fromFriendship(friendship))
              .toList()));

  /// creates friendship with sent state with specified otherUserId
  Future<void> sendRequest(String otherUserId) async {
    final currentUser = await getCurrentUser().first;
    _friendshipService.create(Friendship(
        senderId: currentUser.id!,
        receiverId: otherUserId,
        state: FriendshipState.sent));
  }

  /// accepts friendship specified by friendshipId
  Future<void> acceptRequest(String friendshipId) =>
      _friendshipService.updateState(friendshipId, FriendshipState.accepted);

  /// deletes friendship
  Future<void> deleteFriend(String friendshipId) async {
    await _friendshipService.delete(friendshipId);
  }

  /// finds single friendship matching email of both users
  Future<FriendshipComplete?> findByEmail(
      String firstUserEmail, String secondUserEmail) async {
    final friendships = await _friendshipService.getAll().first;
    final completeFriendships = await Stream.fromIterable(friendships)
        .asyncMap((friendship) => _converterService.fromFriendship(friendship))
        .toList();
    return completeFriendships
        .where((friendship) =>
            (friendship.sender.email.toLowerCase() ==
                    firstUserEmail.toLowerCase() &&
                friendship.receiver.email.toLowerCase() ==
                    secondUserEmail.toLowerCase()) ||
            (friendship.sender.email.toLowerCase() ==
                    secondUserEmail.toLowerCase() &&
                friendship.receiver.email.toLowerCase() ==
                    firstUserEmail.toLowerCase()))
        .singleOrNull;
  }
}
