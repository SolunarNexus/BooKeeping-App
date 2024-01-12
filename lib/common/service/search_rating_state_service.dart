import 'package:book_keeping/common/model/book_rating_aggregate.dart';
import 'package:book_keeping/common/model/sort_state.dart';
import 'package:book_keeping/data_access/facade/book_rating_facade.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchRatingStateService {
  final _ratingFacade = GetIt.instance.get<BookRatingFacade>();
  final _searchStream = BehaviorSubject<String>.seeded("");
  final _sortStream = BehaviorSubject<SortState>.seeded(SortState.byRating);

  Stream<List<BookRatingAggregate>> get stream {
    return Rx.combineLatest3(
      _ratingFacade.getAggregateStream(),
      _searchStream,
      _sortStream,
      (aggregatedRatings, search, sort) {
        return aggregatedRatings
            .where((aggregationRating) => aggregationRating.title
                .toLowerCase()
                .contains(search.toLowerCase()))
            .sorted((a, b) => _compare(a, b, sort));
      },
    );
  }

  Future<void> searchRating(String text) async {
    _searchStream.add(text);
  }

  Future<void> sortRatings(SortState state) async {
    _sortStream.add(state);
  }

  int _compare(BookRatingAggregate a, BookRatingAggregate b, SortState sort) {
    switch (sort) {
      case SortState.byRating:
        return _twoLevelCompare(
            a.ratingAverage, b.ratingAverage, a.ratingCount, b.ratingCount);
      case SortState.byReviews:
        return _twoLevelCompare(
            a.ratingCount, b.ratingCount, a.ratingAverage, b.ratingAverage);
    }
  }

  int _twoLevelCompare(num a1, num b1, num a2, num b2) {
    if (a1 == b1) {
      return a2.compareTo(b2);
    }
    return a1.compareTo(b1);
  }
}
