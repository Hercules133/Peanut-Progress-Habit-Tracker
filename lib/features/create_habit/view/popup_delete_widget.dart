import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart'; 
import 'package:streaks/data/providers/habit_provider.dart'; 
import 'package:provider/provider.dart';

Future<bool> popupDeleteWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
  final habitProvider= Provider.of<HabitProvider> (context, listen: false); 
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
                      Navigator.pop(context, true);
                      habitProvider.deleteHabit(inheritedData.id); 
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
    return result; 
}
