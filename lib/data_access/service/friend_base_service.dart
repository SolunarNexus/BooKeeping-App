import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/friend.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendBaseService {
  CollectionReference<Friend> _getCollection(CollectionType collectionType) {
    if (collectionType != CollectionType.friend &&
        collectionType != CollectionType.friendRequest) {
      throw Exception(
          "This method only supports friend of friend request collections");
    }
    return FirebaseFirestore.instance
        .collection(collectionType.collectionPath)
        .withConverter(
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
  }

  Stream<List<Friend>> baseGetStream(
          CollectionType collectionType, String userId) =>
      _getCollection(collectionType)
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((docSnapshot) => docSnapshot.data())
              .toList());

  Future<void> baseCreate(
      CollectionType collectionType, String userId, String otherUserId) async {
    if (await baseExists(collectionType, userId, otherUserId)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with userId: $userId and otherUserId: $otherUserId already exists");
    }
    final myBook = Friend(userId: userId, otherUserId: otherUserId);
    await _getCollection(collectionType).add(myBook);
  }

  Future<Friend?> baseGetById(CollectionType collectionType, String id) async =>
      (await _getCollection(collectionType).doc(id).get()).data();

  Future<Friend> baseGetByIds(
      CollectionType collectionType, String userId, String otherUserId) async {
    final snapshot = await _getCollection(collectionType)
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .get();
    return snapshot.docs.single.data();
  }

  Future<void> baseDelete(
      CollectionType collectionType, String userId, String otherUserId) async {
    final friend = await baseGetByIds(collectionType, userId, otherUserId);
    _getCollection(collectionType).doc(friend.id).delete();
  }

  Future<bool> baseExists(
      CollectionType collectionType, String userId, String otherUserId) async {
    final countSnapshot = await _getCollection(collectionType)
        .where("userId", isEqualTo: userId)
        .where("otherUserId", isEqualTo: otherUserId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
