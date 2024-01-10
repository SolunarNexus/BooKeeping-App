import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/entity.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirestoreService<T extends Entity> {
  final CollectionType collectionType;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final bool Function(T, T) equals;

  BaseFirestoreService(
      {required this.collectionType,
      required this.fromJson,
      required this.toJson,
      required this.equals});

  CollectionReference<T> _getCollection() => FirebaseFirestore.instance
          .collection(collectionType.collectionPath)
          .withConverter(
        fromFirestore: (snapshot, options) {
          final json = snapshot.data() ?? {};
          json['id'] = snapshot.id;
          return fromJson(json);
        },
        toFirestore: (value, options) {
          final json = toJson(value);
          json.remove('id');
          return json;
        },
      );

  Stream<T?> getSingle(String id) {
    return _getCollection()
        .doc(id)
        .snapshots()
        .map((docSnapshot) => docSnapshot.data());
  }

  Stream<List<T>> getAll() {
    return _getCollection().snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Future<bool> exists(T item) async =>
      (await getAll().first).any((element) => equals(item, element));

  Future<void> create(T item) async {
    if (await exists(item)) {
      throw DuplicateDataException("Item already exists");
    }
    await _getCollection().add(item);
  }

  Future<void> update(T item) async {
    var json = toJson(item);
    json.remove('id');
    return _getCollection().doc(item.id).update(json);
  }

  Future<void> delete(String id) {
    return _getCollection().doc(id).delete();
  }
}
