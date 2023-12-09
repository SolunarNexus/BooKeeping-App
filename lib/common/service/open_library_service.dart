import 'dart:convert';

import 'package:book_keeping/common/model/search_result.dart';
import 'package:http/http.dart' as http;

class OpenLibraryService {
  Future<SearchResult> getBooks() async {
    final response = await http.get(Uri.parse(
        'https://openlibrary.org/search.json?q=the+lord+of+the+rings'));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
