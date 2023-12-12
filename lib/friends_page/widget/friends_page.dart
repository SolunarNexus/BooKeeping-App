import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final friendCard = Card(
      color: Colors.red[300],
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            // Will be replaced by real avatar image
            const Icon(
              Icons.account_circle,
              size: 80,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Bob Doe",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: TopBar(titleText: "My friends", context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            const GeneralSearchBar(),
            GeneralListView(items: List<Card>.generate(7, (_) => friendCard)),
          ],
        ),
      ),
    );
  }
}
