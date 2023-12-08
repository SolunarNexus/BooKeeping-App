import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _pageIndex,
      onDestinationSelected: (int index) => setState(() {
        _pageIndex = index;
        // TODO: fix page redirecting
        context.go("/my-friends");
      }),
      // TODO: set color to transparent in later phase of the project
      // indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.account_box),
          label: 'Friends',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite),
          label: 'My library',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book),
          label: 'Books',
        ),
        NavigationDestination(
          icon: Icon(Icons.leaderboard),
          label: 'Rankings',
        )
      ],
    );
  }
}
