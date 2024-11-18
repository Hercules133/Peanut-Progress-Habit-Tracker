import 'package:flutter/material.dart';

class TitleFormfieldWidget extends StatelessWidget {
  const TitleFormfieldWidget({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: 20,
        controller: titleController,
        decoration: const InputDecoration(
          labelText: "Habit title",
          hintText: "Enter a Habit title",
        ),
        validator: (value) {
          return ("Enter Habit");
          //   value == null || value.isEmpty)
          // ? "Enter task"
          // : model.fetchHabits();
        },
        onChanged: (value) {
          // model.getTask(index).title = value;
          // model.saveData(storageForm);
        });
  }
}
