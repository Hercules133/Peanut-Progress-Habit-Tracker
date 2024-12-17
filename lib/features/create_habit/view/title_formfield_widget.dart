import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';
// import 'package:streaks/features/create_habit/view/inherited_notifier_empty_fields.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';

class TitleFormfieldWidget extends StatelessWidget {
  const TitleFormfieldWidget({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    ValueNotifier<bool> pressed =
        InheritedWidgetCreateHabit.of(context).pressed;
    titleController.text = inheritedData.title;
    debugPrint("before Listenable: ${titleController.text}");
    debugPrint("before Listenable inherited data: ${inheritedData.title}");
    //  debugPrint("before Listenable: ${pressed.toString()}");
    //  final inheritedNotifierEmpty = InheritedNotifierEmptyFields.of(context);
    //  debugPrint("empty before return: ${inheritedNotifierEmpty.empty}");
// final counter = inheritedNotifierEmpty.notifier;
// final pressed = counter?.empty ?? 0;

    return ValueListenableBuilder(
        valueListenable: pressed,
        builder: (context, value, child) {
          //     return
          return TextFormField(
              maxLength: 20,
              autovalidateMode: pressed.value
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Enter a Habit title",
              ),
              validator: (value) {
                // debugPrint("validator: ${inheritedNotifierEmpty.empty.toString()}");
                debugPrint("start validation");
                if (value == null || value.isEmpty) {
                  return 'Title cannot be empty'; // Error message.
                }
                return null;
              },
              onChanged: (value) {
                inheritedData.title = value;
                debugPrint(inheritedData.title);
                debugPrint(titleController.text);
                // debugPrint(pressed.value.toString());
              });
        });
  }
}
