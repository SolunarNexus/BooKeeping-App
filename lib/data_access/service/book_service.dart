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

  Future<void> create(Book book) {
    return _bookCollection.add(book);
  }
}
