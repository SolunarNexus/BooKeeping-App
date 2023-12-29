import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:get_it/get_it.dart';

class MyBookFacade extends BaseFacade {
  final _myBookService = GetIt.instance.get<MyBookService>();
  final _converterService = GetIt.instance.get<ConverterService>();

  /// returns stream of my_books in current user's library
  Future<Stream<List<MyBookComplete>>> getStream() async {
    final currentUser = await getCurrentUser();
    return _myBookService.getStream(currentUser.id!).asyncMap((books) =>
        Stream.fromIterable(books)
            .asyncMap((book) => _converterService.fromMyBook(book))
            .toList());
  }

  /// adds book to current users library
  Future<void> create(String bookId) async {
    final currentUser = await getCurrentUser();
    _myBookService.create(currentUser.id!, bookId);
  }

  /// updates my_book with new read_state
  Future<void> updateState(String myBookId, ReadState newState) =>
      _myBookService.updateState(myBookId, newState);

  /// deletes my_book
  Future<void> deleteById(String id) => _myBookService.deleteById(id);
}
