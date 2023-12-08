import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget topBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    actions: [
      IconButton(onPressed: () => {}, icon: const Icon(Icons.notifications)),
      IconButton(onPressed: () => {}, icon: const Icon(Icons.settings))
    ],
  );
}
