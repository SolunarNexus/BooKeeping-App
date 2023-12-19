import 'package:flutter/material.dart';

class RankingCard extends Card {
  RankingCard(
      {super.key,
      required int rank,
      required String bookTitle,
      required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
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
                ),
              ),
              const Column(
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
        );
}
