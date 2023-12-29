import 'package:book_keeping/data_access/model/friend.dart';
import 'package:book_keeping/data_access/service/friend_request_service.dart';
import 'package:book_keeping/data_access/service/friend_service.dart';
import 'package:get_it/get_it.dart';

class FriendFacade {
  final _friendService = GetIt.instance.get<FriendService>();
  final _friendRequestService = GetIt.instance.get<FriendRequestService>();

  Stream<List<Friend>> getFriendStream(String userId) =>
      _friendService.getStream(userId);

  Stream<List<Friend>> getFriendRequestStream(String userId) =>
      _friendRequestService.getStream(userId);

  Future<void> sendRequest(String myUserId, String otherUserId) =>
      _friendRequestService.create(myUserId, otherUserId);

  Future<void> acceptRequest(String requestId) async {
    final request = await _friendRequestService.getById(requestId);
    if (request == null) {
      throw Exception("Friend request with id: $requestId does not exist");
    }
    await _friendService.create(request.userId, request.otherUserId);
    await _friendService.create(request.otherUserId, request.userId);
    await _friendRequestService.deleteById(requestId);
  }

  Future<void> deleteFriend(String myUserId, String otherUserId) async {
    await _friendService.delete(myUserId, otherUserId);
    await _friendService.delete(otherUserId, myUserId);
  }
}
