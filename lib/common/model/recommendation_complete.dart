import 'package:book_keeping/data_access/model/friendship.dart';

class RecommendationComplete {
  final String? id;
  final Friendship friendship;
  final String bookId;

  RecommendationComplete(
      {this.id, required this.friendship, required this.bookId});
}
