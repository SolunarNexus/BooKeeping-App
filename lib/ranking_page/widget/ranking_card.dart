import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class RankingCard extends Card {
  RankingCard(
      {super.key,
      required int rank,
      required String bookTitle,
      required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () => {
              context.push('/books/$bookTitle'),
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
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
                          initialRating: 2.5,
                          itemCount: 5,
                          ignoreGestures: true,
                          allowHalfRating: true,
                          itemSize: 25,
                          updateOnDrag: true,
                          itemBuilder: (context, index) =>
                              const Icon(Icons.star),
                          onRatingUpdate: (_) {}),
                      const Row(
                        children: [
                          Text("100,000 reviews"),
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
