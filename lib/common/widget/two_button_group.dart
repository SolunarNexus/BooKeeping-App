import 'package:book_keeping/common/model/sort_state.dart';
import 'package:book_keeping/common/service/search_rating_state_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SortButtonGroup extends StatefulWidget {
  final List<bool> _sortSelection = [true, false];
  final List<String> _labels = ["By rating", "By reviews"];
  final _searchRatingStateService =
      GetIt.instance.get<SearchRatingStateService>();

  SortButtonGroup({super.key});

  @override
  State<SortButtonGroup> createState() => _SortButtonGroupState();
}

class _SortButtonGroupState extends State<SortButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: widget._sortSelection,
      onPressed: (int index) => setState(
        () {
          if (!widget._sortSelection[index]) {
            for (int i = 0; i < 2; ++i) {
              widget._sortSelection[i] = index == i;
            }
            widget._searchRatingStateService.sortRatings(
                index == 0 ? SortState.byRating : SortState.byReviews);
          }
        },
      ),
      selectedColor: Colors.white,
      fillColor: Colors.red[300],
      selectedBorderColor: Colors.red[800],
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      constraints: const BoxConstraints(minHeight: 35.0, minWidth: 90.0),
      children: widget._labels.map((label) => Text(label)).toList(),
    );
  }
}
