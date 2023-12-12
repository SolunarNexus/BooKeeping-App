import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final _bookCollection =
      FirebaseFirestore.instance.collection('book').withConverter(
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

  Stream<List<Book>> get stream =>
      _bookCollection.snapshots().map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(Book book) async {
    if (await exists(book.isbn)) {
      throw DuplicateDataException(
          "Book with ISBN: ${book.isbn} already exists");
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
}
