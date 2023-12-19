import 'package:book_keeping/common/model/read_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_book.g.dart';

@JsonSerializable()
class MyBook {
  final String? id;
  final ReadState readState;
  final String userId;
  final String bookId;

  MyBook(
      {this.id,
      required this.readState,
      required this.userId,
      required this.bookId});

  factory MyBook.fromJson(Map<String, dynamic> json) => _$MyBookFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookToJson(this);
}
