import 'package:book_keeping/data_access/model/book_rating.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class BookRatingService extends BaseFirestoreService<BookRating> {
  BookRatingService()
      : super(
            collectionType: CollectionType.bookRating,
            fromJson: BookRating.fromJson,
            toJson: _toJson,
            equals: _equals);

  Stream<List<BookRating>> getAllByBookId(String bookId) =>
      getAll().map((bookRatings) => bookRatings
          .where((bookRating) => bookRating.bookId == bookId)
          .toList());

  Future<void> updateRating(String id, double newValue, String text) async {
    final rating = await getSingle(id).first;
    if (rating == null) {
      throw Exception(
          "${CollectionType.bookRating.collectionPath} with id: $id does not exist");
    }
    await update(rating.copyWith(rating: newValue, text: text));
  }

  Future<BookRating?> getByIds(String userId, String bookId) async {
    final ratings = await getAll().first;
    return ratings
        .where((rating) =>
            rating ==
            BookRating(userId: userId, bookId: bookId, text: "", rating: 0.0))
        .singleOrNull;
  }

  static Map<String, dynamic> _toJson(BookRating bookRating) =>
      bookRating.toJson();

  static bool _equals(BookRating first, BookRating second) => first == second;
}
