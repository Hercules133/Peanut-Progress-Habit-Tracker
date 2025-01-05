import 'package:flutter/material.dart';
import '/data/models/habit.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';

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
        decoration: const InputDecoration(
          hintText: "Enter a description",
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
