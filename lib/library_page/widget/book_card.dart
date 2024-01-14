import 'package:book_keeping/common/model/found_book.dart';
import 'package:book_keeping/data_access/facade/my_book_facade.dart';
import 'package:book_keeping/web_api/service/open_library_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  final _openLibService = GetIt.instance.get<OpenLibraryService>();
  final _myBookFacade = GetIt.instance.get<MyBookFacade>();
  final FoundBook foundBook;

  BookCard({super.key, required this.foundBook});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () async {
          final book = await _openLibService.fetchBook(foundBook);
          if (context.mounted) {
            context.push('/books/detail', extra: book);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: _buildCover(foundBook.coverUrl),
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
                        foundBook.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Authors: ${foundBook.authors.join(", ")}",
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

  Widget _buildCover(String imgUrl) {
    return imgUrl.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: CachedNetworkImage(
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
