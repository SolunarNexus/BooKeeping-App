import 'package:book_keeping/data_access/service/friend_base_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class FriendService extends FriendBaseService {
  @override
  CollectionType getCollectionType() {
    return CollectionType.friend;
  }
}
