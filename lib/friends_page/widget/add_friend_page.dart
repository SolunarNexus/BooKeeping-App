import 'package:book_keeping/common/service/add_friend_state_service.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddFriendPage extends StatelessWidget {
  final _addFriendStateService = GetIt.instance.get<AddFriendStateService>();

  AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              onSubmitted: (value) => _addFriendStateService.searchUser(value),
            ),
            StreamBuilder(
              stream: _addFriendStateService.stream,
              builder: (context, snapshot) => GeneralListView(
                items: [
                  UserCard(
                    userName: snapshot.data?.email ?? "####",
                    addFriend: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
