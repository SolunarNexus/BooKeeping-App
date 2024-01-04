import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class UserFacade {
  final _userService = GetIt.instance.get<UserService>();

  /// creates user
  Future<void> create(String email) => _userService.create(User(email: email));
}
