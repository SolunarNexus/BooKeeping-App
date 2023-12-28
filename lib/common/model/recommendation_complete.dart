import 'package:book_keeping/data_access/model/friendship.dart';

class RecommendationComplete {
  final String? id;
  final Friendship friend;
  final String bookId;

  RecommendationComplete({this.id, required this.friend, required this.bookId});
}
