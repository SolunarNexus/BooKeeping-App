import 'package:book_keeping/common/service/search_friend_state_service.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/model/user.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FriendsPage extends StatelessWidget {
  final _searchFriendStateService =
      GetIt.instance.get<SearchFriendStateService>();

  FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    _searchFriendStateService.searchFriends("");
    return Scaffold(
      appBar:
          TopBar(titleText: "My friends", isFriendPage: true, context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralSearchBar(
              submit: (email) => _searchFriendStateService.searchFriends(email),
            ),
            StreamBuilder<List<User>>(
              stream: _searchFriendStateService.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Flexible(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Flexible(
                    child: Center(
                      child: Text("Nothing to show"),
                    ),
                  );
                }
                return GeneralListView(
                    items: snapshot.data
                        ?.map((user) => UserCard(userName: user.email))
                        .toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
