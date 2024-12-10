import 'package:flutter/material.dart';

import 'package:streaks/core/widgets/details_dialog_heatmap_widget.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/core/utils/routes.dart';

Future<void> showDetailsDialog(BuildContext context, Habit habit) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: ListTile(
            title: Text(
              habit.title,
              style: const TextStyle(fontSize: 25),
            ),
            leading: IconButton(
              onPressed: () {
                habit.toggleComplete(DateTime.now());
              },
              icon: habit.isCompletedOnDate(DateTime.now())
                  ? Image.asset('assets/images/Erdnusse.png')
                  : Image.asset('assets/images/Erdnuss.png'),
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
              Text('${habit.time.hour}:${habit.time.minute}'),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(habit.category.icon),
                      Text(habit.category.name),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Routes.edit, arguments: habit);
                },
                icon: const Icon(Icons.edit),
              )
            ],
          ),
        ],
      );
    },
  );
}
