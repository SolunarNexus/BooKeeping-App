import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/service/base_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class UserService extends BaseService<User> {
  UserService()
      : super(
            collectionType: CollectionType.user,
            fromJson: User.fromJson,
            toJson: _toJson,
            equals: _equals);

  Future<User> getByEmail(String email) async {
    final users = await getAll().last;
    return users.where((user) => user.email == email).single;
  }

  static Map<String, dynamic> _toJson(User user) => user.toJson();

  static bool _equals(User first, User second) => first == second;
}
