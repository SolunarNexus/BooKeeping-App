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

  Future<void> updateRating(String id, int newValue) async {
    final rating = await getSingle(id).last;
    if (rating == null) {
      throw Exception(
          "${CollectionType.bookRating.collectionPath} with id: $id does not exist");
    }
    await update(rating.copyWith(rating: newValue));
  }

  static Map<String, dynamic> _toJson(BookRating bookRating) =>
      bookRating.toJson();

  static bool _equals(BookRating first, BookRating second) => first == second;
}
