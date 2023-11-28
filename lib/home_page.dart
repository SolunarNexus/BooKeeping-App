import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: TextButton(
          child: Text(FirebaseAuth.instance.currentUser!.email!),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              context.go("/auth");
            }
          },
        ),
      ),
    );
  }
}
