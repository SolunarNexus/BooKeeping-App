import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserCard extends StatefulWidget {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _userFacade = GetIt.instance.get<UserFacade>();
  final String userName;
  final bool _addFriend;

  UserCard({super.key, required this.userName, addFriend = false})
      : _addFriend = addFriend;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final List<String> _choices = ["Revoke friendship"];
  var _invitationSent = false;

  @override
  Widget build(context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            // Will be replaced by real avatar image
            child: Icon(Icons.account_circle, size: 80),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              widget.userName,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder<FriendshipComplete?>(
                future: widget._friendshipFacade.getCurrentUser().first.then(
                    (user) => widget._friendshipFacade
                        .findByEmail(user.email, widget.userName)),
                builder: (BuildContext context,
                    AsyncSnapshot<FriendshipComplete?> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return widget._addFriend
                      ? _buildAddFriendControl(snapshot.data)
                      : _buildFriendMenu(snapshot.data);
                },
              ))
        ],
      ),
    );
  }

  IconButton _buildAddFriendControl(FriendshipComplete? friendship) {
    _invitationSent = friendship?.state == FriendshipState.sent;
    return _invitationSent
        ? IconButton(
            onPressed: () => {
                  //TODO: do something meaningful
                  print("Invitation already sent"),
                },
            icon: const Icon(Icons.done, size: 30))
        : IconButton(
            onPressed: () async {
              final otherUser =
                  await widget._userFacade.getByEmail(widget.userName);
              await widget._friendshipFacade.sendRequest(otherUser!.id!);
              _invitationSent = true;
            },
            icon: const Icon(Icons.add));
  }

  MenuAnchor _buildFriendMenu(FriendshipComplete? friendship) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_horiz),
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        _choices.length,
        (int index) => MenuItemButton(
          // TODO: remove friend from DB for current user
          onPressed: () async {
            await widget._friendshipFacade.deleteFriend(friendship!.id!);
          },
          child: Text(_choices[index]),
        ),
      ),
    );
  }
}
