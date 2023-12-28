import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/recommendation.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendationService {
  static const CollectionType collectionType = CollectionType.recommendation;

  final _recommendationCollection = FirebaseFirestore.instance
      .collection(collectionType.collectionPath)
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Recommendation.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Recommendation>> getStream(List<String> friendIds) =>
      _recommendationCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((docSnapshot) => docSnapshot.data())
          .where((recommendation) =>
              friendIds.contains(recommendation.friendshipId))
          .toList());

  Future<void> create(String friendId, String bookId) async {
    if (await exists(friendId, bookId)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with friendshipId: $friendId and bookId: $bookId already exists");
    }
    final recommendation =
        Recommendation(friendshipId: friendId, bookId: bookId);
    await _recommendationCollection.add(recommendation);
  }

  Future<Recommendation> getByIds(String friendId, String bookId) async {
    final snapshot = await _recommendationCollection
        .where("friendshipId", isEqualTo: friendId)
        .where("bookId", isEqualTo: bookId)
        .get();
    return snapshot.docs.single.data();
  }

  Future<void> delete(String friendId, String bookId) async {
    final recommendation = await getByIds(friendId, bookId);
    _recommendationCollection.doc(recommendation.id).delete();
  }

  Future<bool> exists(String friendId, String bookId) async {
    final countSnapshot = await _recommendationCollection
        .where("friendshipId", isEqualTo: friendId)
        .where("bookId", isEqualTo: bookId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
