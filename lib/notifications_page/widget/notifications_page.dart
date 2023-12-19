import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/notifications_page/widget/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "Notifications",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralListView(
              items: List<Card>.generate(
                  7,
                  (_) => NotificationCard(
                        userName: "Bob",
                        prompt: "wants to connect with you",
                        // object: "Book title",
                        context: context,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
