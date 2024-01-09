import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/user.dart';

class FriendshipComplete {
  final String? id;
  final User sender;
  final User receiver;
  final FriendshipState state;

  FriendshipComplete(
      {this.id,
      required this.sender,
      required this.receiver,
      required this.state});

  User getOtherUser(String email) {
    return sender.email == email ? receiver : sender;
  }
}
