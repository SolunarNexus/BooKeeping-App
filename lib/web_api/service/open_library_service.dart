import 'dart:convert';

import 'package:book_keeping/web_api/model/search_result.dart';
import 'package:http/http.dart' as http;

class OpenLibraryService {
  Future<SearchResult> searchBooks(String query) async {
    final noWhitespaceQuery = query.replaceAll(RegExp(r'\s'), "+");
    final response = await http.get(Uri.parse(
        'https://openlibrary.org/search.json?q=$noWhitespaceQuery&fields=key,title,author_name,editions,editions.key'));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load books');
    }
  }
}
