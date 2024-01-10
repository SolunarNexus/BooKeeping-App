import 'package:book_keeping/common/service/search_mybook_state_service.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/three_button_group.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/home_page/widget/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  final _searchMyBookStateService =
      GetIt.instance.get<SearchMyBookStateService>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "My library",
        context: context,
        isHomePage: true,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ThreeButtonGroup(
                  labels: const ["Reading", "Completed", "Plan to read"]),
            ),
            GeneralSearchBar(
                onSubmitted: (value) =>
                    _searchMyBookStateService.searchMyBook(value)),
            StreamBuilder(
              stream: _searchMyBookStateService.stream,
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
                      .map(
                        (bookRecord) => BookCard(
                          bookTitle: bookRecord.book.title,
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
