import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> popupDeleteCategoryWidget(
    BuildContext context, Category categoryToDelete) async {
  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  ValueNotifier<bool> showError = ValueNotifier(false);
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              AppLocalizations.of(context)!.popupDeleteCategoryDeleteButton),
          content: ValueListenableBuilder(
            valueListenable: showError,
            builder: (context, value, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!
                      .popupDeleteCategoryConfirmationMessage),
                  if (value)
                    Text(
                      AppLocalizations.of(context)!
                          .popupDeleteCategoryAssignedHabitsWarning,
                      style: TextStyle(color: Colors.red),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (!checkCategoryForHabits(
                              habitProvider.getAllHabits(), categoryToDelete)) {
                            Navigator.pop(context, true);
                          } else {
                            showError.value = true;
                          }
                        },
                        icon: const Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      });
  return result ?? false;
}

bool checkCategoryForHabits(List<Habit> habits, Category categoryToCheck) {
  for (Habit h in habits) {
    if (h.category == categoryToCheck) {
      return true;
    }
  }
  return false;
}
