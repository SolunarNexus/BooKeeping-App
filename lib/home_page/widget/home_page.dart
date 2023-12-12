import 'package:book_keeping/common/widget/book_list.dart';
import 'package:book_keeping/common/widget/book_search_bar.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/filter_buttons.dart';
import 'package:book_keeping/data_access/model/user.dart' as data_access;
import 'package:book_keeping/data_access/service/book_service.dart';
import 'package:book_keeping/data_access/service/user_service.dart';
import 'package:book_keeping/utils/top_bar.dart';
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
            TextButton(
                onPressed: () async {
                  await userService
                      .create(data_access.User(email: "123@me.com"));
                  final tmp = await userService.exists("1243@me.com");
                  print("user: 123@me.com: $tmp");
                },
                child: const Text("Add")),
            StreamBuilder(
              stream: bookService.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(snapshot.data![index].title),
                            Text(snapshot.data![index].author)
                          ],
                        );
                      },
                    ),
                  );
                }
                return Text("Error");
              },
            )
          ],
        ),
      ),
    );
  }
}
