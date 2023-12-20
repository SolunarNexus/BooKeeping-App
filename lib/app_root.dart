import 'package:book_keeping/book_detail_page/widget/book_detail_page.dart';
import 'package:book_keeping/books_page/widget/books_page.dart';
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
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/my-friends",
        name: "friends",
        builder: (context, state) => const FriendsPage(),
      ),
      GoRoute(
        path: "/ranking",
        name: "rankings",
        builder: (context, state) => const RankingPage(),
      ),
      GoRoute(
        path: "/books",
        name: "books",
        builder: (context, state) => const BooksPage(),
        routes: [
          GoRoute(
              path: ":id",
              builder: (context, state) {
                final bookId = state.pathParameters["bookId"];
                // TODO: return BookDetailPage(id: bookId);
                return const Scaffold();
              }),
        ],
      ),
      GoRoute(
        path: "/notifications",
        name: "notifications",
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: "/book-detail",
        name: "book-detail",
        builder: (context, state) => const BookDetailPage(title: "Book Title"),
      )
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
      ),
      routerConfig: _router,
    );
  }
}
