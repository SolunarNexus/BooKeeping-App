import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationCard = Card(
      color: Colors.red[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Text.rich(
                TextSpan(
                  text: "Bob ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red[100]),
                  children: const <TextSpan>[
                    TextSpan(
                      text: "recommends ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                    TextSpan(text: "Book title")
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              children: [Icon(Icons.check), Icon(Icons.close)],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: TopBar(
        titleText: "Notifications",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            const GeneralSearchBar(),
            GeneralListView(
              items: List<Card>.generate(7, (_) => notificationCard),
            )
          ],
        ),
      ),
    );
  }
}
