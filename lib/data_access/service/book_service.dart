import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class BookService extends BaseFirestoreService<Book> {
  BookService()
      : super(
            collectionType: CollectionType.book,
            fromJson: Book.fromJson,
            toJson: _toJson,
            equals: _equals);

  Future<Book> getByISBN(String isbn) async =>
      (await getAll().first).where((book) => book.isbn == isbn).single;

  static Map<String, dynamic> _toJson(Book book) => book.toJson();

  static bool _equals(Book first, Book second) => first == second;
}
