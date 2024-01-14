import 'package:book_keeping/common/model/found_book.dart';
import 'package:book_keeping/common/service/library_search_state_service.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/general_listview.dart';
import 'package:book_keeping/common/widget/general_search_bar.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/library_page/widget/book_card.dart';
import 'package:book_keeping/web_api/service/open_library_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pair/pair.dart';

class LibraryPage extends StatelessWidget {
  final _openLibService = GetIt.instance.get<OpenLibraryService>();
  final _stateService = GetIt.instance.get<LibrarySearchStateService>();

  LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        titleText: "Library",
        context: context,
      ),
      bottomNavigationBar: BottomMenu(),
      body: Center(
        child: Column(
          children: [
            GeneralSearchBar(onSubmit: (query) async {
              _stateService.setSearchState(true);
              final results = await _openLibService.searchBooks(query);
              _stateService.addResults(results);
              _stateService.setSearchState(false);
            }),
            StreamBuilder<Pair<bool, List<FoundBook>>>(
              stream: _stateService.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.key) {
                  return const CircularProgressIndicator();
                }
                return GeneralListView(
                  items: snapshot.data!.value
                      .map((foundBook) => BookCard(
                            foundBook: foundBook,
                          ))
                      .toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
