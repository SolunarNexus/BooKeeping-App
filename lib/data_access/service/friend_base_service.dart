import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FriendBaseService {
  CollectionType getCollectionType();

  CollectionReference<Friendship> _getCollection() {
    final collectionType = getCollectionType();
    if (collectionType != CollectionType.friendship &&
        collectionType != CollectionType.friendRequest) {
      throw Exception(
          "This method only supports friendship or friend request collections");
    }
    return FirebaseFirestore.instance
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
  }

  Stream<List<Friendship>> getStream(String userId) => _getCollection()
      .where("userId", isEqualTo: userId)
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(String userId, String otherUserId) async {
    if (await exists(userId, otherUserId)) {
      throw DuplicateDataException(
          "${getCollectionType().collectionPath} with userId: $userId and otherUserId: $otherUserId already exists");
    }
    final friendship = Friendship(
        userId: userId, otherUserId: otherUserId, state: FriendshipState.sent);
    await _getCollection().add(friendship);
  }

  Future<Friendship?> getById(String id) async =>
      (await _getCollection().doc(id).get()).data();

  Future<Friendship> getByIds(String userId, String otherUserId) async {
    final snapshot = await _getCollection()
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .get();
    return snapshot.docs.single.data();
  }

  Future<List<Friendship>> getMany(String userId) async {
    final snapshot =
        await _getCollection().where("userId", isEqualTo: userId).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> delete(String userId, String otherUserId) async {
    final friendship = await getByIds(userId, otherUserId);
    await deleteById(friendship.id!);
  }

  Future<void> deleteById(String id) => _getCollection().doc(id).delete();

  Future<bool> exists(String userId, String otherUserId) async {
    final countSnapshot = await _getCollection()
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
