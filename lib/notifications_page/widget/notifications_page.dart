import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/notifications_page/widget/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotificationsPage extends StatelessWidget {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();

  NotificationsPage({super.key});

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
            StreamBuilder<List<FriendshipComplete>>(
              stream: _friendshipFacade.getFriendshipStream().map(
                  (friendships) => friendships
                      .where((friendship) =>
                          friendship.state == FriendshipState.sent)
                      .toList()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return GeneralListView(
                    items: snapshot.data
                        ?.map((friendship) => NotificationCard(
                            userName: friendship
                                .getOtherUser(
                                    FirebaseAuth.instance.currentUser!.email!)
                                .email,
                            prompt: "wants to connect with you",
                            context: context))
                        .toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}
