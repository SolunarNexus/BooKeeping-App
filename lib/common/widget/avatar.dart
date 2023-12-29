import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Avatar extends StatelessWidget {
  final String user;

  const Avatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: Theme.of(context).colorScheme.outline, width: 2),
      ),
      child: Center(
        child: Text(
          _getInitialFromString(user).toUpperCase(),
          style: GoogleFonts.quicksand(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  String _getInitialFromString(String input) => input.isEmpty ? '' : input[0];
}
