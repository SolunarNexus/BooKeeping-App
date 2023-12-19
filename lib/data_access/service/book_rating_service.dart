import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/book_rating.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRatingService {
  final _bookRatingCollection =
      FirebaseFirestore.instance.collection('book_rating').withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return BookRating.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<BookRating>> getStream(String bookId) => _bookRatingCollection
      .where("bookId", isEqualTo: bookId)
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(String userId, String bookId, int rating) async {
    if (await exists(userId, bookId)) {
      throw DuplicateDataException(
          "BookRating with userId: $userId and bookId: $bookId already exists");
    }
    final myBook = BookRating(rating: rating, userId: userId, bookId: bookId);
    await _bookRatingCollection.add(myBook);
  }

  Future<bool> exists(String userId, String bookId) async {
    final countSnapshot = await _bookRatingCollection
        .where("userId", isEqualTo: userId)
        .where("bookId", isEqualTo: bookId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
