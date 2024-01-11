import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchFriendStateService {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _filterStream = BehaviorSubject<String>.seeded("");

  Stream<List<User>> get stream {
    return Rx.combineLatest3(
        _friendshipFacade.getFriendshipStream(),
        _friendshipFacade.getCurrentUser(),
        _filterStream, (friends, currentUser, filter) {
      return friends
          .where((friendship) => friendship.state == FriendshipState.accepted)
          .map((friendship) => friendship.getOtherUser(currentUser.email))
          .where(
              (user) => user.email.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  Future<void> searchFriends(String text) async {
    _filterStream.add(text);
  }
}
