import 'package:book_keeping/home_page/widget/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'authentication/widget/login.dart';

class AppRoot extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: "/auth",
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: "/my-library",
        builder: (context, state) => const HomePage(),
      ),
    ],
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser == null) {
        return "/auth";
      }
      return "/my-library";
    },
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
