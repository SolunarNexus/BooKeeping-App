import 'package:book_keeping/book_detail_page/widget/book_detail_page.dart';
import 'package:book_keeping/library_page/widget/library_page.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/friends_page/widget/add_friend_page.dart';
import 'package:book_keeping/friends_page/widget/friends_page.dart';
import 'package:book_keeping/home_page/widget/home_page.dart';
import 'package:book_keeping/notifications_page/widget/notifications_page.dart';
import 'package:book_keeping/ranking_page/widget/ranking_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'authentication/widget/login.dart';

class AppRoot extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: "/auth",
        name: "login",
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: "/",
        name: "home",
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: "/my-friends",
        name: "friends",
        builder: (context, state) => FriendsPage(),
      ),
      GoRoute(
        path: "/add-friend",
        name: "addFriend",
        builder: (context, state) => AddFriendPage(),
      ),
      GoRoute(
        path: "/ranking",
        name: "rankings",
        builder: (context, state) => RankingPage(),
      ),
      GoRoute(
        path: "/books",
        name: "books",
        builder: (context, state) => const LibraryPage(),
        routes: [
          GoRoute(
            path: "detail",
            builder: (context, state) {
              final book = state.extra as Book;
              return BookDetailPage(book: book);
            },
          ),
        ],
      ),
      GoRoute(
        path: "/notifications",
        name: "notifications",
        builder: (context, state) => NotificationsPage(),
      ),
    ],
    initialLocation: FirebaseAuth.instance.currentUser == null ? "/auth" : "/",
  );

  AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "BookKeeping",
      theme: ThemeData(
        colorSchemeSeed: Colors.brown,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.brown,
        brightness: Brightness.dark,
        useMaterial3: true,
        cardColor: Colors.brown[900],
      ),
      routerConfig: _router,
    );
  }
}
