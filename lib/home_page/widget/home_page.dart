import 'package:book_keeping/common/widget/book_list.dart';
import 'package:book_keeping/common/widget/book_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/filter_buttons.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/data_access/service/book_rating_service.dart';
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/friend_request_service.dart';
import 'package:book_keeping/data_access/service/friend_service.dart';
import 'package:book_keeping/data_access/service/my_book_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:book_keeping/utils/top_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookService = GetIt.instance.get<BookService>();
    final userService = GetIt.instance.get<UserService>();
    final myBookService = GetIt.instance.get<MyBookService>();
    final bookRatingService = GetIt.instance.get<BookRatingService>();
    final friendService = GetIt.instance.get<FriendService>();
    final friendRequestService = GetIt.instance.get<FriendRequestService>();

    return Scaffold(
      appBar: topBar(title: 'My library'),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            FilterButtons(labels: const ['Reading', 'Finished', 'Wishlist']),
            const BookSearchBar(),
            const BookList(),
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
            // TODO: Only for testing purposes, remove later
            TextButton(
                onPressed: () async {
                  final user = await userService.getByEmail("123456@mail.com");
                  final otherUser = await userService.getByEmail("123@me.com");
                  final books = (await FirebaseFirestore.instance
                          .collection('book')
                          .withConverter(
                    fromFirestore: (snapshot, options) {
                      final json = snapshot.data() ?? {};
                      json['id'] = snapshot.id;
                      return Book.fromJson(json);
                    },
                    toFirestore: (value, options) {
                      final json = value.toJson();
                      json.remove('id');
                      return json;
                    },
                  ).get())
                      .docs
                      .map((e) => e.data())
                      .toList();
                  await friendRequestService.create(user.id!, otherUser.id!);
                },
                child: const Text("Add")),
          ],
        ),
      ),
    );
  }
}
