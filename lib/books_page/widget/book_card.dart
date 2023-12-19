import 'package:flutter/material.dart';

class BookCard extends Card {
  BookCard(
      {super.key,
      required String bookTitle,
      required String description,
      required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  children: [
                    Icon(Icons.image, size: 120),
                    Icon(Icons.favorite_border, size: 30),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          bookTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
