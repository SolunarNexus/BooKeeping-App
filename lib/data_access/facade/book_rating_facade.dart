import 'package:book_keeping/common/model/book_rating_aggregate.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/service/book_rating_service.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class BookRatingFacade extends BaseFacade {
  final _bookRatingService = GetIt.instance.get<BookRatingService>();
  final _bookService = GetIt.instance.get<BookService>();

  /// returns stream of book_rating_aggregate, not ordered
  Future<Stream<List<BookRatingAggregate>>> getAggregateStream() async {
    final ratingStream = _bookRatingService.getStream();
    final bookStream = _bookService.getStream();
    return Rx.combineLatest2(ratingStream, bookStream, (ratings, books) {
      final bookGroups = ratings.groupListsBy((element) => element.bookId);
      return books
          .map((book) => BookRatingAggregate(
              bookId: book.id!,
              title: book.title,
              ratingAverage: bookGroups[book.id!]
                      ?.map((rating) => rating.rating)
                      .average ??
                  0,
              ratingCount: bookGroups[book.id!]?.length ?? 0))
          .toList();
    });
  }

  /// creates new rating
  Future<void> create(String bookId, int rating) async {
    final currentUser = await getCurrentUser();
    await _bookRatingService.create(currentUser.id!, bookId, rating);
  }

  /// updates existing rating, verifies ownership of rating
  Future<void> update(String ratingId, int newValue) async {
    final currentUser = await getCurrentUser();
    final rating = await _bookRatingService.getById(ratingId);
    if (rating == null || rating.userId != currentUser.id) {
      throw Exception("Unable to modify rating");
    }
    await _bookRatingService.updateRating(ratingId, newValue);
  }
}
