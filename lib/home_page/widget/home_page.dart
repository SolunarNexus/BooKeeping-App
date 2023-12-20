import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/three_button_group.dart';
import 'package:book_keeping/home_page/widget/book_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "My library",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            ThreeButtonGroup(labels: const ["Reading", "Finished", "Wishlist"]),
            const GeneralSearchBar(),
            GeneralListView(
              items: List<BookCard>.generate(
                  7, (_) => BookCard(bookTitle: "Book title")),
            ),
          ],
        ),
      ),
    );
  }
}
