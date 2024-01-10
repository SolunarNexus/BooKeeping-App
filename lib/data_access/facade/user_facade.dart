import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class UserFacade extends BaseFacade {
  final _userService = GetIt.instance.get<UserService>();

  /// creates user
  Future<void> create(String email) => _userService.create(User(email: email));

  /// gets user by email
  Future<User?> getByEmail(String email) => _userService.getByEmail(email);
}
