import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatefulWidget {
  final String _bookTitle;
  final String _description;
  bool _favourite;

  BookCard(
      {super.key,
      required String bookTitle,
      required String description,
      required BuildContext context,
      bool favourite = false})
      : _bookTitle = bookTitle,
        _description = description,
        _favourite = favourite;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () => {
          context.push('/books/${widget._bookTitle}'),
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  const Icon(Icons.image, size: 120),
                  _buildFavouriteButton(),
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
                        widget._bookTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget._description,
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
      ),
    );
  }

  IconButton _buildFavouriteButton() {
    // TODO: update DB
    updateFavourite(bool fav) => widget._favourite = !fav;

    return widget._favourite
        ? IconButton(
            onPressed: () => setState(() => updateFavourite(widget._favourite)),
            icon: const Icon(Icons.favorite, size: 30.0))
        : IconButton(
            onPressed: () => setState(() => updateFavourite(widget._favourite)),
            icon: const Icon(Icons.favorite_border, size: 30.0));
  }
}
