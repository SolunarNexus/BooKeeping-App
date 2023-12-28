import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:get_it/get_it.dart';

class BookFacade {
  final _bookService = GetIt.instance.get<BookService>();

  /// creates book
  Future<void> create(Book book) => _bookService.create(book);

  /// gets book by id
  Future<Book?> getById(String bookId) => _bookService.getById(bookId);

  /// deletes book
  Future<void> deleteById(String bookId) => _bookService.deleteById(bookId);
}
