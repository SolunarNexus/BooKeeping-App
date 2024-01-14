import 'package:book_keeping/common/service/search_rating_state_service.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/common/widget/two_button_group.dart';
import 'package:book_keeping/ranking_page/widget/ranking_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RankingPage extends StatelessWidget {
  final _searchRatingStateService =
      GetIt.instance.get<SearchRatingStateService>();

  RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(titleText: "Ranking", context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            SortButtonGroup(),
            GeneralSearchBar(submit: (bookTitle) {}),
            StreamBuilder(
              stream: _searchRatingStateService.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return _buildFlexCenteredElement(
                      const CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _buildFlexCenteredElement(
                      Text("Error occurred: ${snapshot.error}"));
                }
                if (snapshot.data!.isEmpty) {
                  return _buildFlexCenteredElement(
                      const Text("Nothing to show"));
                }
                return GeneralListView(
                  items: snapshot.data!
                      .mapIndexed(
                        (index, rating) => RankingCard(
                          bookTitle: rating.title,
                          bookId: rating.bookId,
                          rank: index + 1,
                          count: rating.ratingCount,
                          rating: rating.ratingAverage,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlexCenteredElement(Widget child) {
    return Flexible(
      child: Center(
        child: child,
      ),
    );
  }
}
