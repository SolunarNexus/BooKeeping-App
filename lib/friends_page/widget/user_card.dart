import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/service/user_card_state_service.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserCard extends StatefulWidget {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _userFacade = GetIt.instance.get<UserFacade>();
  final _userCardStateService = GetIt.instance.get<UserCardStateService>();
  final String userName;
  final bool _addFriend;
  final List<String> _choices = ["Revoke friendship"];

  UserCard({super.key, required this.userName, addFriend = false})
      : _addFriend = addFriend;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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
                  if (snapshot.connectionState != ConnectionState.done) {
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

  Widget _buildAddFriendControl(FriendshipComplete? friendship) {
    widget._userCardStateService.changeState(
        friendship?.state == FriendshipState.sent ||
            friendship?.state == FriendshipState.accepted);
    return StreamBuilder<bool>(
      stream: widget._userCardStateService.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return snapshot.data!
            ? IconButton(
                icon: const Icon(Icons.done, size: 30),
                onPressed: () => {
                      print("Invitation already sent"),
                    })
            : IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final otherUser =
                      await widget._userFacade.getByEmail(widget.userName);
                  await widget._friendshipFacade.sendRequest(otherUser!.id!);
                  widget._userCardStateService.changeState(true);
                });
      },
    );
  }

  Widget _buildFriendMenu(FriendshipComplete? friendship) {
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
        widget._choices.length,
        (int index) => MenuItemButton(
          // TODO: remove friend from DB for current user
          onPressed: () async {
            await widget._friendshipFacade.deleteFriend(friendship!.id!);
          },
          child: Text(widget._choices[index]),
        ),
      ),
    );
  }
}
