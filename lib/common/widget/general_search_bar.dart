import 'package:flutter/material.dart';

class GeneralSearchBar extends StatefulWidget {
  final ValueSetter<String>? submit;

  const GeneralSearchBar({super.key, this.submit});

  @override
  State<GeneralSearchBar> createState() => _GeneralSearchBarState();
}

class _GeneralSearchBarState extends State<GeneralSearchBar> {
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
              onPressed: () {
                _searchController.clear();
                widget.submit!("");
              },
              icon: const Icon(Icons.clear),
            ),
          ),
          // onSubmitted: widget.onSubmitted,
          onChanged: widget.submit,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ),
    );
  }
}
