import 'package:book_keeping/data_access/model/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatefulWidget {
  final Book book;

  const BookCard({super.key, required this.book});

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
          context.push('/books/detail', extra: widget.book),
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
                widget.book.title,
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
