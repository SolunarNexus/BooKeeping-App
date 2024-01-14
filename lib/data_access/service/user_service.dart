import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class UserService extends BaseFirestoreService<User> {
  UserService()
      : super(
            collectionType: CollectionType.user,
            fromJson: User.fromJson,
            toJson: _toJson,
            equals: _equals);

  Future<User?> getByEmail(String email) async {
    final users = await getAll().first;
    return users
        .where((user) => user.email.toLowerCase() == email.toLowerCase())
        .singleOrNull;
  }

  Future<User?> getById(String id) async {
    final users = await getAll().first;
    return users.where((user) => user.id == id).singleOrNull;
  }

  static Map<String, dynamic> _toJson(User user) => user.toJson();

  static bool _equals(User first, User second) => first == second;
}
