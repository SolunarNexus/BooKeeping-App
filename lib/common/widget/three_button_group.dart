import 'package:book_keeping/common/model/read_state.dart';
import 'package:book_keeping/common/service/search_mybook_state_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ThreeButtonGroup extends StatefulWidget {
  final List<bool> _filterSelection;
  final List<String> _labels;
  final _searchMyBookStateService =
      GetIt.instance.get<SearchMyBookStateService>();

  ThreeButtonGroup({super.key, required List<String> labels})
      : _labels = labels,
        _filterSelection = List<bool>.generate(labels.length, (_) => false);

  @override
  State<ThreeButtonGroup> createState() => _ThreeButtonGroupState();
}

class _ThreeButtonGroupState extends State<ThreeButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: widget._filterSelection,
      onPressed: (int index) => setState(() {
        if (widget._filterSelection[index]) {
          widget._filterSelection[index] = false;
          widget._searchMyBookStateService.filterMyBooks(null);
        } else {
          for (int i = 0; i < widget._filterSelection.length; ++i) {
            widget._filterSelection[i] = index == i;
          }
          widget._searchMyBookStateService
              .filterMyBooks(ReadState.values[index]);
        }
      }),
      selectedColor: Colors.white,
      fillColor: Colors.red[300],
      selectedBorderColor: Colors.red[800],
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      constraints: const BoxConstraints(minHeight: 35.0, minWidth: 90.0),
      children: widget._labels.map((label) => Text(label)).toList(),
    );
  }
}
