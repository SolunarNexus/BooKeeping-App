import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/filter_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookCard = Card(
      color: Colors.red[300],
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            // Will be replaced by real book cover image
            const Icon(
              Icons.image,
              size: 100,
              color: Colors.black,
            ),
            const Text(
              "Book title",
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
      appBar: TopBar(
        titleText: "My library",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            FilterButtons(labels: const ["Reading", "Finished", "Wishlist"]),
            const GeneralSearchBar(),
            GeneralListView(items: List<Card>.generate(7, (_) => bookCard)),
            // TODO: Only for testing purposes, remove later
            TextButton(
              child: Text(FirebaseAuth.instance.currentUser!.email!),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  context.go("/auth");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
