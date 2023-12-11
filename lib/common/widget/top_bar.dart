import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends AppBar {
  final String titleText;
  final bool includeActions;

  TopBar(
      {super.key,
      required this.titleText,
      this.includeActions = true,
      required BuildContext context})
      : super(
          title: Text(
            titleText,
            style: GoogleFonts.quicksand(
                fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: includeActions
              ? [
                  IconButton(
                      onPressed: () => context.pushNamed("notifications"),
                      icon: const Icon(Icons.notifications)),
                  IconButton(
                      onPressed: () => {}, icon: const Icon(Icons.settings))
                ]
              : null,
        );
}
