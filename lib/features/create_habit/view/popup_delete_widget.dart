import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> popupDeleteWidget(BuildContext context, Habit habit) async {
  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(
                AppLocalizations.of(context)!.popupDeleteHabitDeleteButton),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!
                    .popupDeleteHabitConfirmationMessage),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (habitProvider.habits
                              .any((item) => item.id == habit.id)) {
                            habitProvider.deleteHabit(habit.id);
                          }

                          Navigator.pop(context, true);
                        },
                        icon: const Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ]),
              ],
            ));
      });
  return result ?? false;
}
