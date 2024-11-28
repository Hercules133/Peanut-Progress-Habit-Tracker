import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';

typedef TitleCallback = void Function(String title); 

class TitleFormfieldWidget extends StatelessWidget {
  TitleFormfieldWidget({super.key, required this.titleController, required this.onTitleChanged});

  final TextEditingController titleController;

  final ValueNotifier<String> _title = ValueNotifier<String>("");
  
  final TitleCallback onTitleChanged; 

  @override
  Widget build(BuildContext context) {
     final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
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
                : inheritedData.title ;
              },
              onChanged: (value) {
                 _title.value = value;
                 onTitleChanged(value); 
              });
        });
  }
}
