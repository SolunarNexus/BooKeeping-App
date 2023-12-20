import 'package:book_keeping/common/model/recommendation_complete.dart';
import 'package:book_keeping/common/service/converter_service.dart';
import 'package:book_keeping/data_access/service/friend_service.dart';
import 'package:book_keeping/data_access/service/recommendation_service.dart';
import 'package:get_it/get_it.dart';

class RecommendationFacade {
  final _recommendationService = GetIt.instance.get<RecommendationService>();
  final _friendService = GetIt.instance.get<FriendService>();
  final _converterService = GetIt.instance.get<ConverterService>();

  Future<Stream<List<RecommendationComplete>>> getStream(String userId) async {
    final friendIds = (await _friendService.getMany(userId))
        .map((friend) => friend.id!)
        .toList();
    return _recommendationService.getStream(friendIds).asyncMap(
        (recommendations) => Stream.fromIterable(recommendations)
            .asyncMap((recommendation) =>
                _converterService.fromRecommendation(recommendation))
            .toList());
  }

  Future<void> create(String friendId, String bookId) async =>
      _recommendationService.create(friendId, bookId);

  Future<RecommendationComplete> getByIds(
          String friendId, String bookId) async =>
      _converterService.fromRecommendation(
          await _recommendationService.getByIds(friendId, bookId));

  Future<void> delete(String friendId, String bookId) async =>
      _recommendationService.delete(friendId, bookId);

  Future<bool> exists(String friendId, String bookId) async =>
      _recommendationService.exists(friendId, bookId);
}
