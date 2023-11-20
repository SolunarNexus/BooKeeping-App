import 'package:book_keeping/authentication/widget/login.dart';
import 'package:book_keeping/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Auth error");
          }
          if (!snapshot.hasData) {
            return Login();
          }
          return HomePage();
        },
      ),
    );
  }
}
