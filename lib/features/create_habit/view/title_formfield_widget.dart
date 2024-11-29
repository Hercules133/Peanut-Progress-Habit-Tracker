import 'package:flutter/material.dart';

class TitleFormfieldWidget extends StatelessWidget {
  TitleFormfieldWidget({super.key, required this.titleController});

  final TextEditingController titleController;

  final ValueNotifier<String> _title = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
        valueListenable: _title,
        builder: (context, value, child) {
          return TextFormField(
              maxLength: 20,
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Habit title",
                hintText: "Enter a Habit title",
              ),
              validator: (value) {
                return (value == null || value.isEmpty)
                ? "Enter task"
                : null;
              },
              onChanged: (value) {
                 _title.value = value;
              });
        });
  }
}
