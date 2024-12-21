import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/widgets/details_dialog_heatmap_widget.dart';
import '/data/models/habit.dart';
import '/core/utils/routes.dart';
import '/data/providers/habit_provider.dart';

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
                Text('${habit.time.hour}:${checkMinute(habit.time.minute)}'),
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

String checkMinute(int minutes) {
  if (minutes < 10) {
    return '${minutes}0';
  } else {
    return '$minutes';
  }
}
