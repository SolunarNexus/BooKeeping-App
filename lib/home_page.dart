import 'package:book_keeping/utils/top_bar.dart';
import 'package:book_keeping/widget/book_list.dart';
import 'package:book_keeping/widget/book_search_bar.dart';
import 'package:book_keeping/widget/bottom_menu.dart';
import 'package:book_keeping/widget/filter_buttons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(title: 'My library'),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            FilterButtons(labels: const ['Reading', 'Finished', 'Wishlist']),
            const BookSearchBar(),
            const BookList()
          ],
        ),
      ),
    );
  }
}
