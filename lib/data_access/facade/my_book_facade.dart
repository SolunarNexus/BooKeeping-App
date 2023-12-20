import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:get_it/get_it.dart';

class MyBookFacade {
  final _myBookService = GetIt.instance.get<MyBookService>();
  final _converterService = GetIt.instance.get<ConverterService>();

  Stream<List<MyBookComplete>> getStream(String userId) =>
      _myBookService.getStream(userId).asyncMap((books) {
        final convertedBooks =
            books.map((book) => _converterService.fromMyBook(book));
        return Future.wait(convertedBooks);
      });

  Future<void> create(String userId, String bookId) =>
      _myBookService.create(userId, bookId);

  Future<bool> exists(String userId, String bookId) =>
      _myBookService.exists(userId, bookId);
}
