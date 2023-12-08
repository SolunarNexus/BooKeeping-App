import 'package:book_keeping/utils/top_bar.dart';
import 'package:book_keeping/widget/book_list.dart';
import 'package:book_keeping/widget/book_search_bar.dart';
import 'package:book_keeping/widget/bottom_menu.dart';
import 'package:book_keeping/widget/filter_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            const BookList(),
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
