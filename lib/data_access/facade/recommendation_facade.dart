import 'package:book_keeping/data_access/facade/base_facade.dart';
import 'package:book_keeping/data_access/model/recommendation.dart';
import 'package:book_keeping/data_access/service/friendship_service.dart';
import 'package:book_keeping/data_access/service/recommendation_service.dart';
import 'package:get_it/get_it.dart';

class RecommendationFacade extends BaseFacade {
  final _recommendationService = GetIt.instance.get<RecommendationService>();
  final _friendshipService = GetIt.instance.get<FriendshipService>();

  /// returns stream of recommendations where current user has friendship with sender
  Future<Stream<List<Recommendation>>> getStream() async {
    final currentUser = await getCurrentUser();
    final friendUserIds = _friendshipService.getStream(currentUser.id!).map(
        (friendships) => friendships
            .map((friend) => friend.userId != currentUser.id
                ? friend.userId
                : friend.otherUserId)
            .toList());
    return _recommendationService.getStream(await friendUserIds.last);
  }

  /// sends recommendation to friend
  Future<void> send(String friendUserId, String bookId) async {
    final currentUser = await getCurrentUser();
    _recommendationService.create(currentUser.id!, friendUserId, bookId);
  }

  /// removes recommendation
  Future<void> delete(String recommendationId) =>
      _recommendationService.deleteById(recommendationId);
}
