import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
