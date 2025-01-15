import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:peanutprogress/core/widgets/details_dialog_heatmap_widget.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';

/// A widget that displays a dialog showing detailed information about a habit.
///
/// The [HabitDetailsDialog] class shows a dialog with details about a specific habit, including its title, description, completion status,
/// streak, category, and a heatmap visualization of its progress. It also provides options to mark the habit as completed, edit the habit,
/// or view its heatmap.
///
/// ### Parameters:
/// - [Habit] is the habit object whose details are displayed.
///
/// This dialog includes custom widgets such as [MyHeatMap] for displaying the heatmap and uses [AppLocalizations]
/// for localization.
class HabitDetailsDialog extends StatelessWidget {
  final Habit habit;
  const HabitDetailsDialog({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    return Center(
      child: SizedBox(
        width: 600,
        height: 600,
        child: AlertDialog(
          title: ListTile(
              title: Text(
                habit.title,
                style: const TextStyle(fontSize: 25),
              ),
              leading: IconButton(
                onPressed: () {
                  habitProvider.toggleHabitComplete(habit, DateTime.now());
                },
                icon: SizedBox(
                  width: 40,
                  child: habit.isCompletedOnDate(DateTime.now())
                      ? Image.asset('assets/images/Erdnusse.png')
                      : Image.asset('assets/images/Erdnuss.png'),
                ),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  '${habit.streak}',
                  style: const TextStyle(fontSize: 12),
                ),
                IconButton(
                  icon: Image.asset('assets/images/logo.png'),
                  onPressed: () {},
                ),
              ])),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyHeatMap(
                  habit: habit,
                ),
                Text(
                  habit.description,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${habit.time.hour}:${checkMinute(habit.time.minute)}',
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          habit.category.icon,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        Text(
                          habit.category.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context)
                        .pushNamed(Routes.edit, arguments: habit);
                  },
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to format the minutes for display in habit details.
///
/// The [checkMinute] function checks if the minutes are less than 10 and returns a formatted string with a leading zero if necessary.
///
/// ### Parameters:
/// - [minutes] is the integer value of the minutes to be formatted.
///
/// ### Returns:
/// - A string representing the formatted minutes.
String checkMinute(int minutes) {
  if (minutes < 10) {
    return '${minutes}0';
  } else {
    return '$minutes';
  }
}
