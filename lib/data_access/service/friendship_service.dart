import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendshipService {
  static const CollectionType collectionType = CollectionType.friendship;

  final _friendshipCollection = FirebaseFirestore.instance
      .collection(collectionType.collectionPath)
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Friendship.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Friendship>> getStream(String userId) => _friendshipCollection
      .where(Filter.or(
        Filter("userId", isEqualTo: userId),
        Filter("otherUserId", isEqualTo: userId),
      ))
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(String userId, String otherUserId) async {
    if (await exists(userId, otherUserId)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with userId: $userId and otherUserId: $otherUserId already exists");
    }
    final friendship = Friendship(
        userId: userId, otherUserId: otherUserId, state: FriendshipState.sent);
    await _friendshipCollection.add(friendship);
  }

  Future<void> updateState(String id, FriendshipState newState) async {
    final document = await _friendshipCollection.doc(id).get();
    if (!document.exists) {
      throw Exception(
          "${collectionType.collectionPath} with id: $id does not exist");
    }
    await _friendshipCollection.doc(id).update({"state": newState});
  }

  Future<Friendship> getByIds(String userId, String otherUserId) async {
    final snapshot = await _friendshipCollection
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .get();
    return snapshot.docs.single.data();
  }

  Future<void> deleteById(String id) => _friendshipCollection.doc(id).delete();

  Future<bool> exists(String userId, String otherUserId) async {
    final countSnapshot = await _friendshipCollection
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }

  Future<Friendship?> find(String firstUserId, String secondUserId) async {
    if (await exists(firstUserId, secondUserId)) {
      return await getByIds(firstUserId, secondUserId);
    } else if (await exists(secondUserId, firstUserId)) {
      return await getByIds(secondUserId, firstUserId);
    }
    return null;
  }
}
