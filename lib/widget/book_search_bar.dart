import 'package:flutter/material.dart';

class BookSearchBar extends StatefulWidget {
  const BookSearchBar({super.key});

  @override
  State<BookSearchBar> createState() => _BookSearchBarState();
}

class _BookSearchBarState extends State<BookSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        height: 50.0,
        width: 350.0,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () => _searchController.clear(),
              icon: const Icon(Icons.clear),
            ),
          ),
          onSubmitted: (data) {},
        ),
      ),
    );
  }
}
