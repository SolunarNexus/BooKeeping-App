import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends AppBar {
  final String titleText;
  final bool includeActions;
  final bool includeLeading;

  TopBar(
      {super.key,
      required this.titleText,
      this.includeActions = true,
      this.includeLeading = false,
      required BuildContext context})
      : super(
          title: Text(
            titleText,
            style: GoogleFonts.quicksand(
                fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: includeLeading
              ? IconButton(
                  onPressed: () => context.pushNamed("addFriend"),
                  icon: const Icon(Icons.add, size: 30),
                )
              : null,
          actions: includeActions
              ? [
                  IconButton(
                      onPressed: () => context.pushNamed("notifications"),
                      icon: const Icon(Icons.notifications, size: 25)),
                ]
              : null,
        );
}
