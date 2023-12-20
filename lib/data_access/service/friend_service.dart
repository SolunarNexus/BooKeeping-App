import 'package:book_keeping/data_access/model/friend.dart';
import 'package:book_keeping/data_access/service/friend_base_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class FriendService extends FriendBaseService {
  static const CollectionType collectionType = CollectionType.friend;

  Stream<List<Friend>> getStream(String userId) =>
      super.baseGetStream(collectionType, userId);

  Future<void> create(String userId, String otherUserId) =>
      super.baseCreate(collectionType, userId, otherUserId);

  Future<Friend?> getById(String id) => super.baseGetById(collectionType, id);

  Future<Friend> getByIds(String userId, String otherUserId) =>
      super.baseGetByIds(collectionType, userId, otherUserId);

  Future<void> delete(String userId, String otherUserId) =>
      super.baseDelete(collectionType, userId, otherUserId);

  Future<bool> exists(String userId, String otherUserId) =>
      super.baseExists(collectionType, userId, otherUserId);
}
