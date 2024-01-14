import 'package:book_keeping/data_access/facade/recommendation_facade.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../common/model/friendship_complete.dart';
import '../../data_access/facade/friendship_facade.dart';
import '../../data_access/facade/user_facade.dart';
import '../../data_access/model/book.dart';

class RecommendationCard extends StatefulWidget {
  final String userName;
  final Book book;

  const RecommendationCard(
      {super.key, required this.userName, required this.book});

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  bool _recommendationSent = false;
  final _userFacade = GetIt.instance.get<UserFacade>();

  final _friendshipFacade = GetIt.instance.get<FriendshipFacade>();
  final _recommendationFacade = GetIt.instance.get<RecommendationFacade>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            // Will be replaced by real avatar image
            child: Icon(Icons.account_circle, size: 25),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              widget.userName,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          FutureBuilder<FriendshipComplete?>(
            future: _friendshipFacade.getCurrentUser().first.then((user) =>
                _friendshipFacade.findByEmail(user.email, widget.userName)),
            builder: (BuildContext context,
                AsyncSnapshot<FriendshipComplete?> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              }
              return _buildSendRecommendationControl(snapshot.data);
            },
          )
        ],
      ),
    );
  }

  Widget _buildSendRecommendationControl(FriendshipComplete? friendship) {
    return _recommendationSent
        ? const Icon(Icons.done)
        : IconButton(
            icon: const Icon(Icons.send, size: 20),
            onPressed: () async {
              final user = await _userFacade.getByEmail(widget.userName);
              await _recommendationFacade.send(user!.id!, widget.book.id!);
              setState(() => _recommendationSent = true);
            },
          );
  }
}
