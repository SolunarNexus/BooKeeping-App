import 'package:book_keeping/data_access/model/friend.dart';

class RecommendationComplete {
  final String? id;
  final Friend friend;
  final String bookId;

  RecommendationComplete({this.id, required this.friend, required this.bookId});
}
