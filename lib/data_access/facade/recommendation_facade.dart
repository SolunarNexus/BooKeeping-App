import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:book_keeping/data_access/model/recommendation.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:book_keeping/data_access/service/recommendation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationFacade extends BaseFacade {
  final _recommendationService = GetIt.instance.get<RecommendationService>();
  final _friendshipService = GetIt.instance.get<FriendshipService>();
  final _myBookFacade = GetIt.instance.get<MyBookFacade>();

  /// returns stream of recommendations where current user has friendship with sender
  Stream<List<Recommendation>> getStream() {
    final friendUserIds = getCurrentUser().switchMap((user) =>
        _friendshipService.getAllByUserId(user.id!).map((friendships) =>
            friendships
                .map((friend) => friend.senderId != user.id
                    ? friend.senderId
                    : friend.receiverId)
                .toList()));
    return friendUserIds.switchMap(
        (friendIds) => _recommendationService.getAllByFriendIds(friendIds));
  }

  /// sends recommendation to friend
  Future<void> send(String friendUserId, String bookId) async {
    final currentUser = await getCurrentUser().first;
    final friendship =
        await _friendshipService.find(currentUser.id!, friendUserId);
    if (friendship == null || friendship.state == FriendshipState.sent) {
      throw Exception("Not friends with target user");
    }
    _recommendationService.create(Recommendation(
        senderUserId: currentUser.id!,
        receiverUserId: friendUserId,
        bookId: bookId));
  }

  Future<void> accept(String bookId) async {
    _myBookFacade.createById(bookId);
  }

  /// removes recommendation
  Future<void> delete(String recommendationId) =>
      _recommendationService.delete(recommendationId);
}
