import 'package:flutter/material.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/data/models/date_only.dart';
import 'package:streaks/data/repositories/id_repository.dart';
// import 'package:streaks/features/create_habit/view/inherited_notifier_empty_fields.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

Future<dynamic> popupSavingWidget(BuildContext context) async {
  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
  ValueNotifier<bool> showDaysError =
      InheritedWidgetCreateHabit.of(context).showDaysError;
  ValueNotifier<bool> pressed = InheritedWidgetCreateHabit.of(context).pressed;
//     final inheritedNotifierEmpty = InheritedNotifierEmptyFields.of(context);
// final counter = inheritedNotifierEmpty;

  final habitProvider = Provider.of<HabitProvider>(context, listen: false);
  final idRepository = locator<IdRepository>();
  bool empty = false;

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
                          // inheritedNotifierEmpty.setTrue();
                          pressed.value = true;
                          if (true) {
                            if (inheritedData.days.isEmpty) {
                              showDaysError.value = true;
                              // ScaffoldMessenger.of(context).showSnackBar(
                              // const SnackBar(
                              //     content:
                              //         Text('Please select at least one day!')),
                              // );
                              empty = true;
                            }
                            if (inheritedData.title.isEmpty) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text('Please select a title!')),
                              // );
                              empty = true;
                            }

                            if (empty) {
                              Navigator.of(context).pop(empty);

                              return;
                            }
                          }

                          int id = inheritedData.id == 0
                              ? await idRepository.generateNextHabitId()
                              : inheritedData.id;
                          inheritedData.id = id;
                          inheritedData.progress.addAll({
                            dateOnly(inheritedData.getNextDueDate()):
                                ProgressStatus.notCompleted,
                          });
                          habitProvider.addHabit(inheritedData);
                          if (context.mounted) {
                            Navigator.of(context).pop(inheritedData);
                          }

                          // debugPrint('id: $id');
                          // debugPrint(inheritedData.title);
                          // debugPrint(inheritedData.description);
                          // debugPrint(
                          //     "${inheritedData.time.hour}: ${inheritedData.time.minute}");
                          // debugPrint(inheritedData.days.toString());
                          // debugPrint(inheritedData.category.name);
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
