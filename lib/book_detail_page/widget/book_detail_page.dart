import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class BookDetailPage extends StatefulWidget {
  final String _title;

  // TODO: fetch from DB
  bool _favourite;

  // TODO: fetch from DB
  bool _done;

  // TODO: fetch from DB
  bool _reading;

  BookDetailPage(
      {super.key,
      required String title,
      bool favourite = false,
      bool done = false,
      bool reading = false})
      : _title = title,
        _favourite = favourite,
        _done = done,
        _reading = reading;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  void _updateFavProperty() => widget._favourite = !widget._favourite;

  void _updateDoneProperty() => widget._done = !widget._done;

  void _updateReadingProperty() => widget._reading = !widget._reading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(titleText: widget._title, context: context),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Icon(Icons.image, size: 150),
                    _buildFavouriteButton(),
                    _buildDoneButton(),
                    _buildReadingButton(),
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
                                  onPressed: () {},
                                  child: Text("Rate"),
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: 0,
                                itemCount: 5,
                                // TODO: set to TRUE before production
                                // ignoreGestures: true,
                                allowHalfRating: true,
                                itemSize: 30,
                                updateOnDrag: true,
                                itemBuilder: (context, index) =>
                                    const Icon(Icons.star),
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ),
                        const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam facilisis mi eget ex condimentum elementum. Nam malesuada euismod est, a pellentesque orci. Donec pellentesque, lectus non consectetur rhoncus, sapien purus vulputate est, eget lobortis elit diam vitae nisi. Nulla quis neque sed neque congue vehicula id non ipsum. In sed condimentum velit. Fusce viverra nunc at sollicitudin tempor. Integer semper malesuada eleifend."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // TODO: extract to standalone widget that fetches data from DB (or accepts model object)
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List<Flexible>.generate(
                    3,
                    (index) => Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () =>
                              context.push('/books/Book title ${index + 1}'),
                          child: Column(
                            children: [
                              const Icon(Icons.image, size: 100),
                              Text("Book title ${index + 1}"),
                            ],
                          ),
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

  IconButton _buildSwitchButton(
      {required bool isOn,
      required Icon onIcon,
      required Icon offIcon,
      required void Function() update}) {
    return isOn
        ? IconButton(
            onPressed: () => setState(() => update()),
            icon: onIcon,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        : IconButton(
            onPressed: () => setState(() => update()),
            icon: offIcon,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          );
  }

  IconButton _buildFavouriteButton() {
    return _buildSwitchButton(
        isOn: widget._favourite,
        onIcon: const Icon(Icons.favorite, size: 40.0),
        offIcon: const Icon(Icons.favorite_border, size: 40.0),
        update: _updateFavProperty);
  }

  IconButton _buildDoneButton() {
    return _buildSwitchButton(
        isOn: widget._done,
        onIcon: const Icon(Icons.beenhere, size: 40.0),
        offIcon: const Icon(Icons.beenhere_outlined, size: 40.0),
        update: _updateDoneProperty);
  }

  IconButton _buildReadingButton() {
    return _buildSwitchButton(
        isOn: widget._reading,
        onIcon: const Icon(Icons.bookmark, size: 40.0),
        offIcon: const Icon(Icons.bookmark_border, size: 40.0),
        update: _updateReadingProperty);
  }
}
