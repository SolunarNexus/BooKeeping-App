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
    final friendCard = Card(
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // Will be replaced by real avatar image
            child: Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.black,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              "Bob Doe",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: TopBar(
        titleText: "Add friend",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            const GeneralSearchBar(),
            GeneralListView(
              items: [
                UserCard(
                  userName: "Bob Doe",
                  context: context,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
