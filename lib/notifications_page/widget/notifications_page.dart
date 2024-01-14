import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/book_facade.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/facade/recommendation_facade.dart';
import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:book_keeping/data_access/model/recommendation.dart';
import 'package:book_keeping/notifications_page/widget/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pair/pair.dart';
import 'package:rxdart/rxdart.dart';

class NotificationsPage extends StatelessWidget {
  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _recommendationFacade = GetIt.instance.get<RecommendationFacade>();
  final _bookFacade = GetIt.instance.get<BookFacade>();
  final _userFacade = GetIt.instance.get<UserFacade>();

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
            StreamBuilder<Pair<List<FriendshipComplete>, List<Recommendation>>>(
              stream: Rx.combineLatest2(
                  _friendshipFacade.getFriendshipStream().map((friendships) =>
                      friendships
                          .where((friendship) =>
                              friendship.state == FriendshipState.sent)
                          .where((friendship) =>
                              friendship.sender.email !=
                              FirebaseAuth.instance.currentUser!.email)
                          .toList()),
                  _recommendationFacade.getStream(),
                  (friendships, recommendations) =>
                      Pair(friendships, recommendations)),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Flexible(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.data!.key.isEmpty &&
                    snapshot.data!.value.isEmpty) {
                  return const Flexible(
                      child: Center(child: Text("Nothing to show")));
                }

                final requests = snapshot.data!.key
                    .map((friendship) => NotificationCard(
                          friendEmail: friendship
                              .getOtherUser(
                                  FirebaseAuth.instance.currentUser!.email!)
                              .email,
                          prompt: "wants to connect with you",
                          context: context,
                          onPositive: () =>
                              _friendshipFacade.acceptRequest(friendship.id!),
                          onNegative: () =>
                              _friendshipFacade.deleteFriend(friendship.id!),
                        ))
                    .toList();
                final recommendations =
                    snapshot.data!.value.map((recommendation) {
                  return FutureBuilder(
                    future: _bookFacade.getById(recommendation.bookId),
                    builder: (context3, snapshot3) {
                      return FutureBuilder(
                        future:
                            _userFacade.getById(recommendation.senderUserId),
                        builder: (context4, snapshot4) {
                          if (!snapshot3.hasData || !snapshot4.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return NotificationCard(
                              friendEmail: snapshot4.data!.email,
                              prompt: " recommends you ",
                              object: snapshot3.data!.title,
                              context: context,
                              onPositive: () => _recommendationFacade
                                  .accept(recommendation.bookId),
                              onNegative: () => _recommendationFacade
                                  .delete(recommendation.id!));
                        },
                      );
                    },
                  );
                }).toList();
                return GeneralListView(
                    items: [...requests, ...recommendations]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
