import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchFriendStateService {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _filteredUsers = BehaviorSubject<List<User>>.seeded([]);

  Stream<List<User>> get stream => _filteredUsers.stream;

  Future<void> searchFriends(String text) async {
    final currentUser = await _friendshipFacade.getCurrentUser().first;
    final friends = (await _friendshipFacade.getFriendshipStream().first)
        .where((friendship) => friendship.state == FriendshipState.accepted)
        .map((friendship) => friendship.getOtherUser(currentUser.email));
    final filteredFriends =
        friends.where((user) => user.email.contains(text)).toList();
    _filteredUsers.add(filteredFriends);
  }
}
