import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/model/my_book.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class MyBookFacade extends BaseFacade {
  final _myBookService = GetIt.instance.get<MyBookService>();
  final _bookService = GetIt.instance.get<BookService>();
  final _converterService = GetIt.instance.get<ConverterService>();

  /// returns stream of my_books in current user's library
  Stream<List<MyBookComplete>> getStream() =>
      getCurrentUser().switchMap((user) => _myBookService
          .getAllByUserId(user.id!)
          .asyncMap((books) => Stream.fromIterable(books)
              .asyncMap((book) => _converterService.fromMyBook(book))
              .toList()));

  /// returns stream of my_book specified by isbn and in current user's library
  Stream<MyBookComplete?> getBookStreamByISBN(String isbn) =>
      getStream().map((bookList) =>
          bookList.where((book) => book.book.isbn == isbn).singleOrNull);

  /// adds book by id to current users library
  Future<void> createById(String bookId) async {
    final currentUser = await getCurrentUser().first;
    _myBookService.create(MyBook(
        readState: ReadState.planToRead,
        userId: currentUser.id!,
        bookId: bookId));
  }

  /// adds book to current users library
  Future<void> create(Book book) async {
    if (!(await _bookService.exists(book))) {
      await _bookService.create(book);
    }
    final createdBook = await _bookService.getByISBN(book.isbn);
    await createById(createdBook.id!);
  }

  /// updates my_book with new read_state
  Future<void> updateState(String myBookId, ReadState newState) =>
      _myBookService.updateState(myBookId, newState);

  /// deletes my_book
  Future<void> deleteById(String id) => _myBookService.delete(id);
}
