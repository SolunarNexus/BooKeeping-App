import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  static const CollectionType collectionType = CollectionType.book;

  final _bookCollection = FirebaseFirestore.instance
      .collection(collectionType.collectionPath)
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return Book.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<Book>> getStream() =>
      _bookCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(Book book) async {
    if (await exists(book.isbn)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with ISBN: ${book.isbn} already exists");
    }
    await _bookCollection.add(book);
  }

  Future<Book?> getById(String id) async =>
      (await _bookCollection.doc(id).get()).data();

  Future<bool> exists(String isbn) async {
    final countSnapshot =
        await _bookCollection.where("isbn", isEqualTo: isbn).count().get();
    return countSnapshot.count > 0;
  }

  Future<void> deleteById(String id) => _bookCollection.doc(id).delete();
}
