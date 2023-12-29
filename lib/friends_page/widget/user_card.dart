import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String userName;
  final bool _addFriend;

  const UserCard({super.key, required this.userName, addFriend = false})
      : _addFriend = addFriend;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final List<String> _choices = ["Revoke friendship"];
  bool _invitationSent = false;

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
            child: widget._addFriend
                ? _buildAddFriendControl()
                : _buildFriendMenu(),
          )
        ],
      ),
    );
  }

  IconButton _buildAddFriendControl() {
    // TODO: here we can check in DB for friendship status (invited) instead
    return _invitationSent
        ? IconButton(
            onPressed: () => {
                  print("Invitation already sent"),
                },
            icon: const Icon(Icons.done, size: 30))
        : IconButton(
            onPressed: () => setState(() => {
                  // TODO: check if invitation was already sent, otherwise send invitation and update DB
                  print("Invitation sent"),
                  _invitationSent = true,
                }),
            icon: const Icon(Icons.add));
  }

  MenuAnchor _buildFriendMenu() {
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
          onPressed: () => print("Friendship revoked"),
          child: Text(_choices[index]),
        ),
      ),
    );
  }
}
