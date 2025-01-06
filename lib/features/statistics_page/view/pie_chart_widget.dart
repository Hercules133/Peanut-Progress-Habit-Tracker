import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key});

  List<OrdinalData> ordinalDataList = [];

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final allCategories = categoryProvider.categories;

    List<Habit> habits = habitProvider.habits;

    List<Habit> todayHabits = [];
    List<Category> addedCategories = [];
    Map<Category, int> categoryCounts = {};

    for (Habit habit in habits) {
      if (habit.isCompletedOnDate(DateTime.now())) {
        todayHabits.add(habit);
        if (!categoryCounts.containsKey(habit.category)) {
          categoryCounts[habit.category] = 1;
        } else {
          categoryCounts[habit.category] = categoryCounts[habit.category]! + 1;
        }
      }
    }

    categoryCounts.forEach((category, count) {
      double percentage = (count / todayHabits.length) * 100;
      ordinalDataList.add(OrdinalData(
          domain: category.name, measure: percentage, color: category.color));
    });

    if (ordinalDataList.isEmpty) {
      ordinalDataList = [
        OrdinalData(
          domain: 'No Data',
          measure: 100,
          color: Colors.grey,
        ),
      ];
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text(
            'Completed today (%/category)',
            textAlign: TextAlign.center,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: DChartPieO(
            data: ordinalDataList,
            customLabel: (ordinalData, index) {
              if (ordinalData.measure > 15) {
                return '${ordinalData.domain}\n${ordinalData.measure.toStringAsFixed(1)}%';
              } else {
                return '${ordinalData.measure.toStringAsFixed(1)}%';
              }
            },
            configRenderPie: ConfigRenderPie(
              strokeWidthPx: 2,
              arcLabelDecorator: ArcLabelDecorator(),
            ),
          ),
        ),
      ],
    );
  }
}
