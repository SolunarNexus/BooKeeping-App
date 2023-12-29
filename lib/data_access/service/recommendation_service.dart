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

  Stream<List<Recommendation>> getStream(List<String> friendUserIds) =>
      _recommendationCollection.snapshots().map((querySnapshot) => querySnapshot
          .docs
          .map((docSnapshot) => docSnapshot.data())
          .where((recommendation) =>
              friendUserIds.contains(recommendation.senderUserId))
          .toList());

  Future<void> create(
      String senderUserId, String receiverUserId, String bookId) async {
    if (await exists(senderUserId, receiverUserId, bookId)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with senderUserId: $senderUserId, receiverUserId: $receiverUserId and bookId: $bookId already exists");
    }
    final recommendation = Recommendation(
        senderUserId: senderUserId,
        receiverUserId: receiverUserId,
        bookId: bookId);
    await _recommendationCollection.add(recommendation);
  }

  Future<void> deleteById(String id) =>
      _recommendationCollection.doc(id).delete();

  Future<bool> exists(
      String senderUserId, String receiverUserId, String bookId) async {
    final countSnapshot = await _recommendationCollection
        .where("senderUserId", isEqualTo: senderUserId)
        .where("receiverUserId", isEqualTo: receiverUserId)
        .where("bookId", isEqualTo: bookId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
