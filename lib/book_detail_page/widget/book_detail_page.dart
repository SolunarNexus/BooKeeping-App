import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailPage extends StatelessWidget {
  final String _title;

  const BookDetailPage({super.key, required String title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(titleText: _title, context: context),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Icon(Icons.image, size: 150),
                    Icon(Icons.favorite_border, size: 40),
                    Icon(Icons.beenhere_outlined, size: 40),
                    Icon(Icons.bookmark_border, size: 40),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 25,
                                width: 80,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("Rate")),
                              ),
                              RatingBar.builder(
                                  initialRating: 0,
                                  itemCount: 5,
                                  // ignoreGestures: true,
                                  allowHalfRating: true,
                                  itemSize: 30,
                                  updateOnDrag: true,
                                  itemBuilder: (context, index) =>
                                      const Icon(Icons.star),
                                  onRatingUpdate: (_) {}),
                            ],
                          ),
                        ),
                        const Text("Some interesting description of the book"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 370,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Publisher: E corp."),
                            Text("Publication date: 2022-01-10"),
                            Text("Publication place: Mississippi"),
                            Text("ISBN: 10909122-ALLSS"),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Categories: fantasy, sci-fi"),
                            Text("Language: English"),
                            Text("Pages: 198")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Text("You may also like"),
                Row(
                  children: List<Flexible>.generate(
                    3,
                    (index) => Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const Icon(Icons.image, size: 100),
                            Text(
                                "Book title Book title Book title Book title Book title Book title Book title ${index + 1}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
