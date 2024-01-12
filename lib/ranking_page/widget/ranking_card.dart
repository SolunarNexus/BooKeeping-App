import 'package:book_keeping/data_access/facade/book_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RankingCard extends Card {
  final _bookFacade = GetIt.instance.get<BookFacade>();
  final int rank;
  final double rating;
  final int count;
  final String bookTitle;
  final String bookId;

  RankingCard(
      {super.key,
      required this.bookId,
      required this.bookTitle,
      required this.count,
      required this.rating,
      required this.rank});

  @override
  Widget build(context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () async {
          final book = await _bookFacade.getById(bookId);
          if (context.mounted) {
            context.push('/books/detail', extra: book);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "$rank.",
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  bookTitle,
                  style: const TextStyle(fontSize: 19),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                      initialRating: rating,
                      itemCount: 5,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      itemSize: 25,
                      updateOnDrag: true,
                      itemBuilder: (context, index) => const Icon(Icons.star),
                      onRatingUpdate: (_) {}),
                  Row(
                    children: [
                      Text("$count reviews"),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
