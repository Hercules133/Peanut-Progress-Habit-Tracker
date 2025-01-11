import 'package:flutter/material.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import '/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> popupDeleteWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
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
                              .any((item) => item.id == inheritedData.id)) {
                            habitProvider.deleteHabit(inheritedData.id);
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
