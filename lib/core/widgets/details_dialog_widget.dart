import 'package:flutter/material.dart';

import 'package:streaks/core/utils/hexcolor.dart';
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
              style: TextStyle(fontSize: 25),
            ),
            leading: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/images/Erdnuss.png')),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(
                '${habit.streak}',
                style: TextStyle(fontSize: 12),
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
              MyHeatMap(habit: habit,),
              Text(
                habit.description,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
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
                  // color: HexColor(habit.category.color),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0), // Mehr Platz
                  child: Row(
                    children: [
                      // habit.category.icon,
                      Text(habit.category.name),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.addAndEdit); // this has to take us to the edit page later
                },
                child: const Icon(Icons.edit),
              )
            ],
          ),
        ],
      );
    },
  );
}
