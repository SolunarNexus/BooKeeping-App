import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friendsFacade = GetIt.instance.get<FriendshipFacade>();

    return Scaffold(
      appBar:
          TopBar(titleText: "My friends", isFriendPage: true, context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralSearchBar(
              onSubmitted: (email) => {},
            ),
            StreamBuilder(
              stream: friendsFacade.getFriendshipStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.data!.isEmpty) {
                  return const Flexible(
                    child: Center(child: Text("No Friends yet")),
                  );
                }
                return GeneralListView(
                    items: snapshot.data
                        ?.map((friendship) =>
                            UserCard(userName: friendship.otherUser.email))
                        .toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
