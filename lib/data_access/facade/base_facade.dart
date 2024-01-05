import 'package:book_keeping/data_access/model/user.dart' as db_user;
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

abstract class BaseFacade {
  final _userService = GetIt.instance.get<UserService>();

  /// gets user from db based on current logged in user
  Stream<db_user.User> getCurrentUser() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) {
      throw Exception("User not logged in");
    }
    return _userService
        .getAll()
        .map((users) => users.where((user) => user.email == email).single);
  }
}
