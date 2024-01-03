import 'package:book_keeping/common/exception/duplicate_data_exception.dart';
import 'package:book_keeping/data_access/model/entity.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService<T extends Entity> {
  final CollectionType _collectionType;
  final T Function(Map<String, dynamic>) _fromJson;
  final Map<String, dynamic> Function(T) _toJson;
  final bool Function(T, T) _equals;

  BaseService(
      {required CollectionType collectionType,
      required T Function(Map<String, dynamic>) fromJson,
      required Map<String, dynamic> Function(T) toJson,
      required bool Function(T, T) equals})
      : _collectionType = collectionType,
        _fromJson = fromJson,
        _toJson = toJson,
        _equals = equals;

  CollectionReference<T> _getCollection() => FirebaseFirestore.instance
          .collection(_collectionType.collectionPath)
          .withConverter(
        fromFirestore: (snapshot, options) {
          final json = snapshot.data() ?? {};
          json['id'] = snapshot.id;
          return _fromJson(json);
        },
        toFirestore: (value, options) {
          final json = _toJson(value);
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
      (await getAll().last).any((element) => _equals(item, element));

  Future<void> create(T item) async {
    if (await exists(item)) {
      throw DuplicateDataException("Item already exists");
    }
    await _getCollection().add(item);
  }

  Future<void> update(T item) async {
    return _getCollection().doc(item.id).update(_toJson(item));
  }

  Future<void> remove(String id) {
    return _getCollection().doc(id).delete();
  }
}
