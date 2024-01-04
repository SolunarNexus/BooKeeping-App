import 'package:book_keeping/data_access/model/recommendation.dart';
import 'package:book_keeping/data_access/service/base_firestore_service.dart';
import 'package:book_keeping/data_access/utility/collection_type.dart';

class RecommendationService extends BaseFirestoreService<Recommendation> {
  RecommendationService()
      : super(
            collectionType: CollectionType.recommendation,
            fromJson: Recommendation.fromJson,
            toJson: _toJson,
            equals: _equals);

  Stream<List<Recommendation>> getStream(List<String> friendUserIds) =>
      getAll().map((recommendations) => recommendations
          .where((recommendation) =>
              friendUserIds.contains(recommendation.senderUserId))
          .toList());

  static Map<String, dynamic> _toJson(Recommendation recommendation) =>
      recommendation.toJson();

  static bool _equals(Recommendation first, Recommendation second) =>
      first == second;
}
