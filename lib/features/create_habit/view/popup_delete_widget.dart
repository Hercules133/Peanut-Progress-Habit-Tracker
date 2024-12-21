import 'package:flutter/material.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import '/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

Future<bool> popupDeleteWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Delete'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Do you want to delete this Habit?"),
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
