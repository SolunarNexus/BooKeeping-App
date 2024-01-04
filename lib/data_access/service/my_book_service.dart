import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/data_access/model/my_book.dart';
import 'package:book_keeping/data_access/service/base_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class MyBookService extends BaseService<MyBook> {
  MyBookService()
      : super(
            collectionType: CollectionType.myBook,
            fromJson: MyBook.fromJson,
            toJson: _toJson,
            equals: _equals);

  Stream<List<MyBook>> getStream(String userId) => getAll().map(
      (myBooks) => myBooks.where((myBook) => myBook.userId == userId).toList());

  Future<void> updateState(String id, ReadState newState) async {
    final myBook = await getSingle(id).last;
    if (myBook == null) {
      throw Exception(
          "${CollectionType.myBook.collectionPath} with id: $id does not exist");
    }
    await update(myBook.copyWith(readState: newState));
  }

  static Map<String, dynamic> _toJson(MyBook myBook) => myBook.toJson();

  static bool _equals(MyBook first, MyBook second) => first == second;
}
