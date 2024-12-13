import 'package:flutter/material.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/data/models/date_only.dart';
import 'package:streaks/data/repositories/id_repository.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> popupSavingWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  final idRepository = locator<IdRepository>();
  int id = inheritedData.id == 0
      ? await idRepository.generateNextHabitId()
      : inheritedData.id;
  inheritedData.id = id;
  inheritedData.progress.addAll({
    dateOnly(inheritedData.getNextDueDate()): ProgressStatus.notCompleted,
  });

  if (!context.mounted) return;
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
                        onPressed: () async {
                          Navigator.of(context).pop(inheritedData);
                          habitProvider.addHabit(inheritedData);
                          debugPrint('id: $id');
                          debugPrint(inheritedData.title);
                          debugPrint(inheritedData.description);
                          debugPrint(
                              "${inheritedData.time.hour}: ${inheritedData.time.minute}");
                          debugPrint(inheritedData.days.toString());
                          debugPrint(inheritedData.category.name);
                        },
                        icon: const Icon(Icons.check),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ]),
              ],
            ));
      });
}
