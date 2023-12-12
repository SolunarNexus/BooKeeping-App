import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/data_access/model/my_book.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class ConverterService {
  final _userService = GetIt.instance.get<UserService>();
  final _bookService = GetIt.instance.get<BookService>();

  Future<MyBookComplete> fromMyBook(MyBook myBook) async {
    final user = await _userService.getById(myBook.userId);
    if (user == null) {
      throw Exception("User with id: ${myBook.userId} does not exist");
    }
    final book = await _bookService.getById(myBook.userId);
    if (book == null) {
      throw Exception("Book with id: ${myBook.bookId} does not exist");
    }
    return MyBookComplete(
        id: myBook.id, readState: myBook.readState, user: user, book: book);
  }

  Future<MyBook> toMyBook(MyBookComplete myBook) async {
    if (myBook.user.id == null || myBook.book.id == null) {
      throw Exception("Missing reference id");
    }
    return MyBook(
        id: myBook.id,
        readState: myBook.readState,
        userId: myBook.user.id!,
        bookId: myBook.book.id!);
  }
}
