import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class SearchMyBookStateService {
  final _myBookFacade = GetIt.instance.get<MyBookFacade>();
  final _searchStream = BehaviorSubject<String>.seeded("");
  final _filterStream = BehaviorSubject<ReadState?>.seeded(null);

  Stream<List<MyBookComplete>> get stream {
    return Rx.combineLatest3(
        _myBookFacade.getStream(), _searchStream, _filterStream,
        (myBooks, search, filter) {
      return myBooks
          .where((myBook) => myBook.book.title.contains(search))
          .where((myBook) => filter == null || myBook.readState == filter)
          .toList();
    });
  }

  Future<void> searchMyBook(String text) async {
    _searchStream.add(text);
  }

  Future<void> filterMyBooks(ReadState? state) async {
    _filterStream.add(state);
  }
}
