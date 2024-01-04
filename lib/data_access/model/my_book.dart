import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/data_access/model/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_book.g.dart';

@JsonSerializable()
class MyBook extends Entity {
  final ReadState readState;
  final String userId;
  final String bookId;

  MyBook(
      {super.id,
      required this.readState,
      required this.userId,
      required this.bookId});

  factory MyBook.fromJson(Map<String, dynamic> json) => _$MyBookFromJson(json);

  Map<String, dynamic> toJson() => _$MyBookToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyBook &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          bookId == other.bookId;

  @override
  int get hashCode => userId.hashCode ^ bookId.hashCode;

  MyBook copyWith({
    ReadState? readState,
    String? userId,
    String? bookId,
  }) {
    return MyBook(
      readState: readState ?? this.readState,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
    );
  }
}
