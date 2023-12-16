import 'package:flutter/material.dart';

class GeneralListView extends StatelessWidget {
  final List<Card> _items;

  const GeneralListView({super.key, required items}) : _items = items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return _items[index];
        },
      ),
    );
  }
}
