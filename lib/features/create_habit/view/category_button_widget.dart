import 'package:flutter/material.dart';
import '/data/models/category.dart';
import '/data/models/habit.dart';
import '/data/models/own_colors.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';

class CategoryButtonWidget extends StatelessWidget {
  CategoryButtonWidget(
      {super.key, required this.category, required this.color});

  final Category category;
  final Color color;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    if (inheritedData.category == category) {
      _hasBeenPressed.value = true;
    }
    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
              style: ButtonStyle(
                backgroundColor: _hasBeenPressed.value
                    ? WidgetStatePropertyAll(ownColors.contribution2)
                    : WidgetStatePropertyAll<Color>(ownColors.contribution1),
              ),
              onPressed: () {
                _hasBeenPressed.value = !_hasBeenPressed.value;
                if (_hasBeenPressed.value) {
                  inheritedData.category = category;
                }
              },
              child: Text(category.name));
        });
  }
}
