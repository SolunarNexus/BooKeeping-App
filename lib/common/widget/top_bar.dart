import 'package:book_keeping/common/widget/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends AppBar {
  final String titleText;
  final bool includeActions;
  final bool isFriendPage;
  final bool isHomePage;

  TopBar(
      {super.key,
      required this.titleText,
      this.includeActions = true,
      this.isFriendPage = false,
      this.isHomePage = false,
      required BuildContext context})
      : super(
          title: Text(
            titleText,
            style: GoogleFonts.quicksand(
                fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: isFriendPage
              ? IconButton(
                  onPressed: () => context.pushNamed("addFriend"),
                  icon: const Icon(Icons.add, size: 30),
                )
              : isHomePage
                  ? Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: MenuAnchor(
                        menuChildren: [
                          MenuItemButton(
                            child: const Text("Log out"),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              if (context.mounted) {
                                context.goNamed("login");
                              }
                            },
                          ),
                        ],
                        builder: (context, controller, child) => ClipOval(
                          child: Material(
                            child: InkWell(
                              onTap: () => controller.isOpen
                                  ? controller.close()
                                  : controller.open(),
                              child: Avatar(
                                user: FirebaseAuth.instance.currentUser!.email!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
          actions: includeActions
              ? [
                  IconButton(
                      // restrict notifications page nesting
                      onPressed: () => context.canPop()
                          ? {}
                          : context.pushNamed("notifications"),
                      icon: const Icon(Icons.notifications, size: 25)),
                ]
              : null,
        );
}
