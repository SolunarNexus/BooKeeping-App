import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/filter_buttons.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rankingCard = Card(
      color: Colors.red[300],
      child: const SizedBox(
        height: 100,
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            // Will be replaced by real avatar image
            Text(
              "1.",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Book title",
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Icon(Icons.star),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.star_border),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("100,000 reviews"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: TopBar(titleText: "Ranking", context: context),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            // TODO: needs more suitable name or another specialized widget for sorting
            FilterButtons(
                labels: const ["By reviews", "By ranking", "Combined"]),
            const GeneralSearchBar(),
            GeneralListView(items: List<Card>.generate(7, (_) => rankingCard)),
          ],
        ),
      ),
    );
  }
}
