import 'package:book_keeping/common/model/found_book.dart';
import 'package:pair/pair.dart';
import 'package:rxdart/rxdart.dart';

class LibrarySearchStateService {
  final _searchResults = BehaviorSubject<List<FoundBook>>.seeded([]);
  final _searching = BehaviorSubject<bool>.seeded(false);

  Stream<Pair<bool, List<FoundBook>>> get stream => Rx.combineLatest2(
      _searching.stream,
      _searchResults.stream,
      (searching, results) => Pair(searching, results));

  void addResults(List<FoundBook> results) {
    _searchResults.add(results);
  }

  void setSearchState(bool searching) {
    _searching.add(searching);
  }
}
