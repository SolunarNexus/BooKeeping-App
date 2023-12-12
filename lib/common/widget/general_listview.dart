import 'package:flutter/material.dart';

class GeneralListView extends StatelessWidget {
  final List<Card> _items;

  const GeneralListView({super.key, required items}) : _items = items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return _items[index];
          // return Card(
          //   color: Colors.red[400],
          //   child: SizedBox(
          //     height: 100,
          //     child: Row(
          //       children: [
          //         // Will be replaced by real book cover image
          //         const Icon(
          //           Icons.image,
          //           size: 100,
          //           color: Colors.black,
          //         ),
          //         const Text(
          //           'Book title',
          //           style: TextStyle(color: Colors.black, fontSize: 19),
          //         ),
          //         const Spacer(),
          //         IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.menu,
          //             color: Colors.black,
          //             size: 30.0,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
