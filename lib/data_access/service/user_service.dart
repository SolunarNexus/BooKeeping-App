import 'package:book_keeping/data_access/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _userCollection =
      FirebaseFirestore.instance.collection('user').withConverter(
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

  Future<void> create(User user) {
    return _userCollection.add(user);
  }

  Future<bool> exists(String email) async {
    final countSnapshot =
        await _userCollection.where("email", isEqualTo: email).count().get();
    return countSnapshot.count > 0;
  }
}
