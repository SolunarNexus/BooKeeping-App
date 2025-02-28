import 'dart:convert';

import 'package:book_keeping/common/model/found_book.dart';
import 'package:book_keeping/data_access/model/book.dart';
import 'package:book_keeping/web_api/model/author_result.dart';
import 'package:book_keeping/web_api/model/book_result.dart';
import 'package:book_keeping/web_api/model/search_result.dart';
import 'package:http/http.dart' as http;

class OpenLibraryService {
  static String baseUrl = "openlibrary.org";

  Future<List<FoundBook>> searchBooks(String query) async {
    final noWhitespaceQuery = query.replaceAll(RegExp(r'\s'), "+");
    final queryParms = {
      "q": noWhitespaceQuery,
      "fields": "key,title,author_name,editions,editions.key"
    };
    final response =
        await http.get(Uri.https(baseUrl, "/search.json", queryParms));
    if (response.statusCode == 200) {
      final result = SearchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      return _fromSearchResult(result);
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> fetchBook(FoundBook foundBook) async {
    final response = await http
        .get(Uri.https(baseUrl, "/books/${foundBook.editionOLID}.json"));
    if (response.statusCode == 200) {
      final bookResult = BookResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
      final authorResultList =
          await Stream.fromIterable(bookResult.authors ?? [])
              .asyncMap((author) {
        final authorOLID = author.key.replaceAll(RegExp(r'/authors/'), "");
        return _fetchAuthor(authorOLID);
      }).toList();
      return _fromBookResultAndFoundBook(
          bookResult, foundBook, authorResultList);
    } else {
      throw Exception('Failed to fetch book');
    }
  }

  Future<AuthorResult> _fetchAuthor(String authorOLID) async {
    final response =
        await http.get(Uri.https(baseUrl, "/authors/$authorOLID.json"));
    if (response.statusCode == 200) {
      return AuthorResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch author');
    }
  }

  List<FoundBook> _fromSearchResult(SearchResult searchResult) {
    return searchResult.docs
        .where((work) => work.editions.docs.length == 1)
        .map((work) {
      final editionOLID =
          work.editions.docs.single.key.replaceAll(RegExp(r'/books/'), "");
      final coverUrl =
          "https://covers.openlibrary.org/b/olid/$editionOLID-M.jpg";
      return FoundBook(
          editionOLID: editionOLID,
          title: work.title,
          authors: work.authorName ?? [],
          coverUrl: coverUrl);
    }).toList();
  }

  Book _fromBookResultAndFoundBook(BookResult bookResult, FoundBook foundBook,
      List<AuthorResult> authorResultList) {
    return Book(
        description: bookResult.description,
        imgUrl: foundBook.coverUrl,
        publishDate: bookResult.publishDate ?? "No date provided",
        publishers: bookResult.publishers ?? [],
        pages: bookResult.numberOfPages,
        languages: bookResult.languages
                ?.map((language) =>
                    language.key.replaceAll(RegExp(r'/languages/'), ""))
                .toList() ??
            [],
        categories: bookResult.subjects ?? [],
        isbn: bookResult.isbn?.first ??
            "No isbn provided, OLID: ${foundBook.editionOLID}",
        title: foundBook.title,
        authors: authorResultList.map((author) => author.name).toList());
  }
}
