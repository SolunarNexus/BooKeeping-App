import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _userCollection = FirebaseFirestore.instance
      .collection(CollectionType.user.collectionPath)
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return User.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Future<void> create(String email) async {
    final user = User(email: email);
    if (await exists(email)) {
      throw DuplicateDataException("User with email: $email already exists");
    }
    await _userCollection.add(user);
  }

  Future<User> getByEmail(String email) async {
    final snapshot =
        await _userCollection.where("email", isEqualTo: email).get();
    return snapshot.docs.single.data();
  }

  Future<User?> getById(String id) async =>
      (await _userCollection.doc(id).get()).data();

  Future<bool> exists(String email) async {
    final countSnapshot =
        await _userCollection.where("email", isEqualTo: email).count().get();
    return countSnapshot.count > 0;
  }
}
