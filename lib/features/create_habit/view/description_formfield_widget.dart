import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';

class DescriptionFormfieldWidget extends StatelessWidget {
  const DescriptionFormfieldWidget(
      {super.key, required this.descriptionController});

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    descriptionController.text = inheritedData.description;
    return TextFormField(
        maxLength: 150,
        controller: descriptionController,
        decoration: InputDecoration(
          hintText: "Enter a description",
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface, width: 2),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1),
          ),
        ),
        cursorColor: Theme.of(context).colorScheme.onSurface,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? "Enter description"
              : inheritedData.description;
        },
        onChanged: (value) {
          inheritedData.description = value;
        });
  }
}
