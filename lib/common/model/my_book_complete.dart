import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/model/user.dart';

class MyBookComplete {
  final String? id;
  final ReadState readState;
  final User user;
  final Book book;

  MyBookComplete(
      {this.id,
      required this.readState,
      required this.user,
      required this.book});
}
