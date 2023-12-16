import 'package:flutter/material.dart';

class BookCard extends Card {
  BookCard({super.key, required String title, required BuildContext context})
      : super(
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              // Will be replaced by real book cover image
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.image,
                  size: 100,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 19),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.more_horiz,
                    size: 30.0,
                  ),
                ),
              )
            ],
          ),
        );
}
