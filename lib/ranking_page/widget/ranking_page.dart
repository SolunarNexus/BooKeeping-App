import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/three_button_group.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/ranking_page/widget/ranking_card.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(titleText: "Ranking", context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            ThreeButtonGroup(
                labels: const ["By reviews", "By ranking", "Combined"]),
            GeneralSearchBar(submit: (bookTitle) {}),
            GeneralListView(
              items: List<Card>.generate(
                7,
                (index) => RankingCard(
                    rank: index + 1, bookTitle: "Book Title", context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
