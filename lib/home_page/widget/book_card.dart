import 'package:book_keeping/data_access/model/book.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatefulWidget {
  final Book book;

  BookCard({super.key, required this.book});

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
            // TODO: Will be replaced by real book cover image
            _buildCover(widget.book.imgUrl),
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

  Widget _buildCover(String imgUrl) {
    return imgUrl.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: CachedNetworkImage(
              // alignment: Alignment.center,
              imageUrl: imgUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          )
        : const Icon(
            Icons.image,
            size: 100,
          );
  }
}
