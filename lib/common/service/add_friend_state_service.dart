import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class AddFriendStateService {
  final _userService = GetIt.instance.get<UserService>();
  final _foundUser = BehaviorSubject<User?>();

  Stream<User?> get stream => _foundUser.stream;

  void searchUser(String email) {
    _userService.getByEmail(email).then((user) => _foundUser.add(user));
  }
}
