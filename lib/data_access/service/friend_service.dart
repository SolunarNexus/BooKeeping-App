import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendService {
  final _friendCollection =
      FirebaseFirestore.instance.collection('friend').withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Friend.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Friend>> getStream(String userId) => _friendCollection
      .where("userId", isEqualTo: userId)
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(String userId, String otherUserId) async {
    if (await exists(userId, otherUserId)) {
      throw DuplicateDataException(
          "Friend with userId: $userId and friendId: $otherUserId already exists");
    }
    final myBook = Friend(userId: userId, otherUserId: otherUserId);
    await _friendCollection.add(myBook);
  }

  Future<Friend> getByIds(String userId, String otherUserId) async {
    final snapshot = await _friendCollection
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .get();
    return snapshot.docs.single.data();
  }

  Future<void> delete(String userId, String otherUserId) async {
    final friend = await getByIds(userId, otherUserId);
    _friendCollection.doc(friend.id).delete();
  }

  Future<bool> exists(String userId, String otherUserId) async {
    final countSnapshot = await _friendCollection
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
