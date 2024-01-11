import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:get_it/get_it.dart';

class BookFacade {
  final _bookService = GetIt.instance.get<BookService>();

  /// creates book
  Future<void> create(Book book) => _bookService.create(book);

  /// gets book by id
  Future<Book?> getById(String bookId) async =>
      await _bookService.getSingle(bookId).first;

  /// gets book by title
  Future<Book> getByTitle(String title) async {
    final books = await _bookService.getAll().first;
    return books.where((book) => book.title == title).single;
  }

  /// deletes book
  Future<void> deleteById(String bookId) => _bookService.delete(bookId);
}
