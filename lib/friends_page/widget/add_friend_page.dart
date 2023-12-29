import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/friends_page/widget/user_card.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "Add friend",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: const Center(
        child: Column(
          children: [
            GeneralSearchBar(),
            GeneralListView(items: [
              UserCard(
                userName: "Bob Doe",
                addFriend: true,
              )
            ])
          ],
        ),
      ),
    );
  }
}
