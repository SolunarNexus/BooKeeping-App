import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomMenu extends StatelessWidget {
  BottomMenu({super.key});

  final List<String> _links = ['friends', 'home', 'books', 'rankings'];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (int index) => context.goNamed(_links[index]),
      indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.account_box),
          label: 'Friends',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.leaderboard),
          label: 'Rankings',
        )
      ],
    );
  }
}
