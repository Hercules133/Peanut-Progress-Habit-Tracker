import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionFormfieldWidget extends StatelessWidget {
  const DescriptionFormfieldWidget({
    super.key,
    required this.descriptionController,
    required this.habit,
  });

  final TextEditingController descriptionController;
  final ValueNotifier<Habit> habit;

  @override
  Widget build(BuildContext context) {
    descriptionController.text = habit.value.description;
    return TextFormField(
        maxLength: 150,
        controller: descriptionController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.descriptionFormfieldHintText,
        ),
        cursorColor: Theme.of(context).colorScheme.onSurface,
        validator: (value) {
          return (value == null || value.isEmpty)
              ? AppLocalizations.of(context)!.descriptionFormfieldLabel
              : habit.value.description;
        },
        onChanged: (value) {
          habit.value.description = value;
        });
  }
}
