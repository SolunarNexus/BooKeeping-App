import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class AddFriendStateService {
  final _userFacade = GetIt.instance.get<UserFacade>();
  final _foundUser = BehaviorSubject<User?>();

  Stream<User?> get stream => _foundUser.stream;

  Future<void> searchUser(String email) async {
    final currentUser = await _userFacade.getCurrentUser().first;
    final foundUser = await _userFacade.getByEmail(email);
    if (foundUser == null || foundUser.email == currentUser.email) {
      _foundUser.add(null);
      return;
    }
    _foundUser.add(foundUser);
  }
}
