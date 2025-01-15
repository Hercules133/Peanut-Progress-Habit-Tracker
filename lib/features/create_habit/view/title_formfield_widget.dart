import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A formfield widget to set/change the title of a habit.
///
/// This widget is used in the [CreateHabitFormWidget] to set the title of a habit.
/// It uses a [TextEditingController] to control the text input and a [ValueNotifier] to update the habit object.
/// The [pressed] notifier is used to validate the formfield only when the user presses the save button.
///
/// ### Required parameters:
/// - [titleController] is the controller for the text input.
/// - [pressed] is a notifier to check if the user pressed the save button.
/// - [habit] is the habit object to update.
///
/// ### Validation:
/// The formfield cannot be empty and has a maximum length of 20 characters.
///
class TitleFormfieldWidget extends StatelessWidget {
  const TitleFormfieldWidget(
      {super.key,
      required this.titleController,
      required this.pressed,
      required this.habit});

  final TextEditingController titleController;
  final ValueNotifier<bool> pressed;
  final ValueNotifier<Habit> habit;

  @override
  Widget build(BuildContext context) {
    titleController.text = habit.value.title;

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
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!
                .titleFormfieldTitleEmptyError; // Error message.
          }
          return null;
        },
        onChanged: (value) {
          habit.value.title = value;
        });
  }
}
