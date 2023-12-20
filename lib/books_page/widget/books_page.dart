import 'package:book_keeping/books_page/widget/book_card.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
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
