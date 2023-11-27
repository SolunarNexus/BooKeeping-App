import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  final String title;
  final bool includeActions;

  const TopBar({super.key, required this.title, this.includeActions = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: includeActions
          ? [
              IconButton(
                  onPressed: () => {}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () => {}, icon: const Icon(Icons.settings))
            ]
          : null,
    );
  }
}
