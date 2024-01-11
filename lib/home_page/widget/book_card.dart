import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatefulWidget {
  bool _favourite;
  final String bookTitle;

  BookCard({super.key, required this.bookTitle, favourite = true})
      : _favourite = favourite;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Card build(context) {
    return Card(
      color: Theme.of(context).cardColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => {
          context.push('/books/${widget.bookTitle}'),
        },
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
                widget.bookTitle,
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
