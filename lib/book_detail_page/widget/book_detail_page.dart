import 'package:book_keeping/common/model/my_book_complete.dart';
import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/common/widget/bottom_menu.dart';
import 'package:book_keeping/common/widget/top_bar.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';

class BookDetailPage extends StatelessWidget {
  final _myBookFacade = GetIt.instance.get<MyBookFacade>();
  final Book book;

  BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(titleText: book.title, context: context),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<MyBookComplete?>(
                  stream: _myBookFacade.getBookStreamByISBN(book.isbn),
                  builder: (context, myBookSnapshot) {
                    return Column(
                      children: [
                        _buildCover(book.imgUrl),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child:
                              _buildFavouriteButton(myBookSnapshot.hasData, () {
                            if (!myBookSnapshot.hasData) {
                              _myBookFacade.create(book);
                            } else {
                              _myBookFacade
                                  .deleteById(myBookSnapshot.data!.id!);
                            }
                          }),
                        ),
                        _buildReadingButton(myBookSnapshot.data, book),
                        _buildDoneButton(myBookSnapshot.data, book),
                      ],
                    );
                  },
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
                                  // TODO
                                  onPressed: () {},
                                  child: const Text("Rate"),
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
                        Text(book.description ?? "No description provided"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildBookDetails(book),
          ],
        ),
      ),
    );
  }

  Widget buildBookDetails(Book book) {
    return Container(
      width: 370,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailPart("Authors: ", book.authors.join(", ")),
                    _buildDetailPart(
                        "Publishers: ", book.publishers.join(", ")),
                    _buildDetailPart("Publication date: ", book.publishDate),
                    _buildDetailPart("ISBN: ", book.isbn),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailPart(
                        "Categories: ", book.categories.join(", ")),
                    _buildDetailPart("Languages: ", book.languages.join(", ")),
                    _buildDetailPart(
                        "Pages: ", (book.pages ?? "N/A").toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildDetailPart(String header, String body) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: header,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          TextSpan(text: body)
        ]),
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
            onPressed: () => update(),
            icon: onIcon,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        : IconButton(
            onPressed: () => update(),
            icon: offIcon,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          );
  }

  IconButton _buildFavouriteButton(
      bool isFavourite, VoidCallback addToMyBooks) {
    return _buildSwitchButton(
        isOn: isFavourite,
        onIcon: const Icon(Icons.favorite, size: 40.0),
        offIcon: const Icon(Icons.favorite_border, size: 40.0),
        update: addToMyBooks);
  }

  IconButton _buildDoneButton(MyBookComplete? myBook, Book book) {
    final isOn = myBook != null && myBook.readState == ReadState.completed;
    return _buildSwitchButton(
        isOn: isOn,
        onIcon: const Icon(Icons.beenhere, size: 40.0),
        offIcon: const Icon(Icons.beenhere_outlined, size: 40.0),
        update: () async {
          String myBookId;
          if (myBook == null) {
            await _myBookFacade.create(book);
            myBookId =
                (await _myBookFacade.getBookStreamByISBN(book.isbn).first)!.id!;
          } else {
            myBookId = myBook.id!;
          }
          await _myBookFacade.updateState(
              myBookId, isOn ? ReadState.planToRead : ReadState.completed);
        });
  }

  IconButton _buildReadingButton(MyBookComplete? myBook, Book book) {
    final isOn = myBook != null && myBook.readState == ReadState.reading;
    return _buildSwitchButton(
      isOn: isOn,
      onIcon: const Icon(Icons.bookmark, size: 45.0),
      offIcon: const Icon(Icons.bookmark_border, size: 45.0),
      update: () async {
        String myBookId;
        if (myBook == null) {
          await _myBookFacade.create(book);
          myBookId =
              (await _myBookFacade.getBookStreamByISBN(book.isbn).first)!.id!;
        } else {
          myBookId = myBook.id!;
        }
        await _myBookFacade.updateState(
            myBookId, isOn ? ReadState.planToRead : ReadState.reading);
      },
    );
  }

  Widget _buildCover(String imgUrl) {
    return imgUrl.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: CachedNetworkImage(
              width: 100,
              imageUrl: imgUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
        : const Icon(Icons.image, size: 150);
  }
}
