import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/model/user.dart';

class FriendshipComplete {
  final String? id;
  final User user;
  final User otherUser;
  final FriendshipState state;

  FriendshipComplete(
      {this.id,
      required this.user,
      required this.otherUser,
      required this.state});

  User getOtherUser(String email) {
    return user.email == email ? otherUser : user;
  }
}
