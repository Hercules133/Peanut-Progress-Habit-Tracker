import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';

class TitleFormfieldWidget extends StatelessWidget {
  const TitleFormfieldWidget({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    titleController.text = inheritedData.title;
    return TextFormField(
        maxLength: 20,
        controller: titleController,
        decoration: InputDecoration(
          hintText: "Enter a Habit title",
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
              ? "Enter title"
              : inheritedData.title;
        },
        onChanged: (value) {
          value.isEmpty ? "darf nicht leer sein" : inheritedData.title = value;
        });
  }
}
