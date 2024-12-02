import 'package:flutter/material.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';

class CategoryButtonWidget extends StatelessWidget {
  CategoryButtonWidget(
      {super.key, required this.category, required this.color});

  final String category;
  final Color color;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    Category c; 
    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
              style: ButtonStyle(
                  backgroundColor: _hasBeenPressed.value
                  ? const WidgetStatePropertyAll(Colors.yellow)
                  : WidgetStatePropertyAll<Color>(inheritedData.category.color),
              ),
              onPressed: () {
                _hasBeenPressed.value = !_hasBeenPressed.value;
                //inheritedData.category= category; 
                },
              child: Text(category));
        });
  }
}
