import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookCard = Card(
      color: Colors.red[300],
      child: const SizedBox(
        height: 200,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    Icons.image,
                    size: 120,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.favorite_border,
                  size: 30,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Book title",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: Text(
                    "Some interesting description of the book",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: TopBar(
        titleText: "Books",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            const GeneralSearchBar(),
            GeneralListView(items: List<Card>.generate(7, (_) => bookCard))
          ],
        ),
      ),
    );
  }
}
