import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/common/utility/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/my_book.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookService {
  static const CollectionType collectionType = CollectionType.myBook;

  final _myBookCollection = FirebaseFirestore.instance
      .collection(collectionType.collectionPath)
      .withConverter(
    fromFirestore: (snapshot, options) {
      final json = snapshot.data() ?? {};
      json['id'] = snapshot.id;
      return MyBook.fromJson(json);
    },
    toFirestore: (value, options) {
      final json = value.toJson();
      json.remove('id');
      return json;
    },
  );

  Stream<List<MyBook>> getStream(String userId) => _myBookCollection
      .where("userId", isEqualTo: userId)
      .snapshots()
      .map((querySnapshot) =>
          querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());

  Future<void> create(String userId, String bookId) async {
    if (await exists(userId, bookId)) {
      throw DuplicateDataException(
          "${collectionType.collectionPath} with userId: $userId and bookId: $bookId already exists");
    }
    final myBook =
        MyBook(readState: ReadState.planToRead, userId: userId, bookId: bookId);
    await _myBookCollection.add(myBook);
  }

  Future<bool> exists(String userId, String bookId) async {
    final countSnapshot = await _myBookCollection
        .where("userId", isEqualTo: userId)
        .where("bookId", isEqualTo: bookId)
        .count()
        .get();
    return countSnapshot.count > 0;
  }
}
