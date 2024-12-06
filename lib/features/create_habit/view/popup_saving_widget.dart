import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart'; 
import 'package:streaks/data/providers/habit_provider.dart'; 
import 'package:provider/provider.dart';

Future<void> popupSavingWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
  final habitProvider= Provider.of<HabitProvider> (context, listen: false); 
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Save'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Do you want to save this Habit?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      habitProvider.addHabit(inheritedData); 
                      debugPrint(inheritedData.title);
                      debugPrint(inheritedData.description);  
                      debugPrint("${inheritedData.time.hour}: ${inheritedData.time.minute}");
                      debugPrint(inheritedData.days.toString()); 
                      debugPrint(inheritedData.category.name); 

                    },
                    icon: const Icon(Icons.check),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ]),
              ],
            ));
      });
}