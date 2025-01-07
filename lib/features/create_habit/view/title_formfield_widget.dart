import 'package:flutter/material.dart';
import '/data/models/habit.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleFormfieldWidget extends StatelessWidget {
  const TitleFormfieldWidget(
      {super.key, required this.titleController, required this.pressed});

  final TextEditingController titleController;
  final ValueNotifier<bool> pressed;

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    // ValueNotifier<bool> pressed =
    //     InheritedWidgetCreateHabit.of(context).pressed;
    titleController.text = inheritedData.title;
    debugPrint("before Listenable: ${titleController.text}");
    debugPrint("before Listenable inherited data: ${inheritedData.title}");
    //  debugPrint("before Listenable: ${pressed.toString()}");
    //  final inheritedNotifierEmpty = InheritedNotifierEmptyFields.of(context);
    //  debugPrint("empty before return: ${inheritedNotifierEmpty.empty}");
// final counter = inheritedNotifierEmpty.notifier;
// final pressed = counter?.empty ?? 0;

    // return ValueListenableBuilder(
    //     valueListenable: pressed,
    //     builder: (context, value, child) {
    //     return
    return TextFormField(
        maxLength: 20,
        autovalidateMode:
            pressed.value ? AutovalidateMode.always : AutovalidateMode.disabled,
        controller: titleController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.titleFormfieldHabitHintText,
        ),
        cursorColor: Theme.of(context).colorScheme.onSurface,
        validator: (value) {
          // debugPrint("validator: ${inheritedNotifierEmpty.empty.toString()}");
          debugPrint("start validation");
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!
                .titleFormfieldTitleEmptyError; // Error message.
          }
          return null;
        },
        onChanged: (value) {
          inheritedData.title = value;
          debugPrint(inheritedData.title);
          debugPrint(titleController.text);
          // debugPrint(pressed.value.toString());
        });
    // });
  }
}
