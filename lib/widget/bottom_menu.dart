import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  int _pageIndex = 1;
  BottomMenu({super.key});
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: widget._pageIndex,
      onDestinationSelected: (int index) => setState(() {
        widget._pageIndex = index;
      }),
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
