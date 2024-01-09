import 'package:book_keeping/common/exception/not_found_exception.dart';
import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/data_access/model/friendship.dart';
import 'package:book_keeping/data_access/model/my_book.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:get_it/get_it.dart';

class ConverterService {
  final _userService = GetIt.instance.get<UserService>();
  final _bookService = GetIt.instance.get<BookService>();

  Future<MyBookComplete> fromMyBook(MyBook myBook) async {
    final user = await _userService.getSingle(myBook.userId).first;
    if (user == null) {
      throw NotFoundException("User with id: ${myBook.userId} does not exist");
    }
    final book = await _bookService.getSingle(myBook.bookId).first;
    if (book == null) {
      throw NotFoundException("Book with id: ${myBook.bookId} does not exist");
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

  Future<FriendshipComplete> fromFriendship(Friendship friendship) async {
    final sender = await _userService.getSingle(friendship.senderId).first;
    if (sender == null) {
      throw NotFoundException(
          "User with id: ${friendship.senderId} does not exist");
    }
    final receiver = await _userService.getSingle(friendship.receiverId).first;
    if (receiver == null) {
      throw NotFoundException(
          "User with id: ${friendship.receiverId} does not exist");
    }
    return FriendshipComplete(
        id: friendship.id,
        sender: sender,
        receiver: receiver,
        state: friendship.state);
  }

  Future<Friendship> toFriendship(FriendshipComplete friendship) async {
    if (friendship.sender.id == null || friendship.receiver.id == null) {
      throw Exception("Missing reference id");
    }
    return Friendship(
        id: friendship.id,
        state: friendship.state,
        senderId: friendship.sender.id!,
        receiverId: friendship.receiver.id!);
  }
}
