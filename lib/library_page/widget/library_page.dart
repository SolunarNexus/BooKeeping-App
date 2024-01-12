import 'package:book_keeping/library_page/widget/book_card.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "Library",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralSearchBar(submit: (bookTitle) {}),
            GeneralListView(
              items: List<BookCard>.generate(
                7,
                (_) => BookCard(
                    bookTitle: "Book Title",
                    description: "Some interesting description of the book.",
                    context: context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
