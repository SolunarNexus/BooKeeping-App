import 'package:book_keeping/common/model/friendship_complete.dart';
import 'package:book_keeping/common/model/friendship_state.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/book_facade.dart';
import 'package:book_keeping/data_access/facade/friendship_facade.dart';
import 'package:book_keeping/data_access/facade/recommendation_facade.dart';
import 'package:book_keeping/data_access/facade/user_facade.dart';
import 'package:book_keeping/notifications_page/widget/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_access/model/book.dart';

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
            StreamBuilder<List<FriendshipComplete>>(
              stream: _friendshipFacade.getFriendshipStream().map(
                  (friendships) => friendships
                      .where((friendship) =>
                          friendship.state == FriendshipState.sent)
                      .where((friendship) =>
                          friendship.sender.email !=
                          FirebaseAuth.instance.currentUser!.email)
                      .toList()),
              builder: (context, snapshot) {
                return StreamBuilder(
                  stream: _recommendationFacade.getStream(),
                  builder: (context2, snapshot2) {
                    if (!snapshot.hasData || !snapshot2.hasData) {
                      return const Flexible(
                          child: Center(child: CircularProgressIndicator()));
                    }
                    if (snapshot.data!.isEmpty && snapshot2.data!.isEmpty) {
                      return const Flexible(
                          child: Center(child: Text("Nothing to show")));
                    }

                    final requests = snapshot.data!
                        .map((friendship) => NotificationCard(
                              friendEmail: friendship
                                  .getOtherUser(
                                      FirebaseAuth.instance.currentUser!.email!)
                                  .email,
                              prompt: "wants to connect with you",
                              context: context,
                              onPositive: () => _friendshipFacade
                                  .acceptRequest(friendship.id!),
                              onNegative: () => _friendshipFacade
                                  .deleteFriend(friendship.id!),
                            ))
                        .toList();
                    final recommendations =
                        snapshot2.data!.map((recommendation) {
                      return FutureBuilder(
                        future: _bookFacade.getById(recommendation.bookId),
                        builder: (context3, snapshot3) {
                          return FutureBuilder(
                            future: _userFacade
                                .getById(recommendation.senderUserId),
                            builder: (context4, snapshot4) {
                              return NotificationCard(
                                  friendEmail: snapshot4.data!.email,
                                  prompt: " recommends you ",
                                  object: snapshot3.data!.title,
                                  context: context,
                                  onPositive: () => _recommendationFacade
                                      .accept(recommendation.bookId),
                                  onNegative: () => _recommendationFacade
                                      .delete(recommendation.id!));
                              // final requests = snapshot.data!
                              //     .map((friendship) => NotificationCard(
                              //           friendEmail: friendship
                              //               .getOtherUser(FirebaseAuth
                              //                   .instance.currentUser!.email!)
                              //               .email,
                              //           prompt: "wants to connect with you",
                              //           context: context,
                              //           onPositive: () => _friendshipFacade
                              //               .acceptRequest(friendship.id!),
                              //           onNegative: () => _friendshipFacade
                              //               .deleteFriend(friendship.id!),
                              //         ))
                              //     .toList();
                              // final recommendations = snapshot2.data!
                              //     .map((recommendation) => NotificationCard(
                              //         friendEmail: snapshot4.data!.email,
                              //         prompt: " recommends you ",
                              //         context: context,
                              //         onPositive: () => _recommendationFacade
                              //             .accept(recommendation.bookId),
                              //         onNegative: () => _recommendationFacade
                              //             .delete(recommendation.id!)))
                              //     .toList();
                              // return GeneralListView(
                              //     items: requests + recommendations);
                            },
                          );
                        },
                      );
                    }).toList();

                    return GeneralListView(
                        items: requests /*+ recommendations*/);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
