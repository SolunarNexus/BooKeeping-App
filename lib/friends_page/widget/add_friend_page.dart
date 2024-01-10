import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../common/service/add_friend_state_service.dart';

class AddFriendPage extends StatelessWidget {
  final _addFriendStateService = GetIt.instance.get<AddFriendStateService>();
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();

  AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    _addFriendStateService.searchUser("");
    return Scaffold(
      appBar: TopBar(
        titleText: "Add friend",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralSearchBar(
              onSubmitted: (value) {
                _addFriendStateService.searchUser(value);
              },
            ),
            StreamBuilder(
              stream: _addFriendStateService.stream,
              builder: (context, snapshot) {
                final List<UserCard> items = snapshot.hasData
                    ? [
                        UserCard(
                          userName: snapshot.data!.email,
                          addFriend: true,
                        )
                      ]
                    : [];
                return GeneralListView(
                  items: items,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
