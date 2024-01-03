import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/book_rating.dart';
import 'package:book_keeping/data_access/service/base_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookRatingService extends BaseService<BookRating> {
  BookRatingService()
      : super(
      collectionType: CollectionType.bookRating,
      fromJson: BookRating.fromJson,
      toJson: _toJson,
      equals: _equals);

  Future<void> updateRating(String id, int newValue) async {
    final rating = await getSingle(id).last;
    if (rating == null) {
      throw Exception(
          "${CollectionType.bookRating} with id: $id does not exist");
    }
    rating
    await _bookRatingCollection.doc(id).update({"rating": newValue});
  }

  static Map<String, dynamic> _toJson(BookRating bookRating) =>
      bookRating.toJson();

  static bool _equals(BookRating first, BookRating second) => first == second;
}
