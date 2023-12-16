import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          titleText: "My friends", includeLeading: true, context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            const GeneralSearchBar(),
            GeneralListView(
                items: List<Card>.generate(
                    7, (_) => UserCard(userName: "Bob Doe", context: context))),
          ],
        ),
      ),
    );
  }
}
