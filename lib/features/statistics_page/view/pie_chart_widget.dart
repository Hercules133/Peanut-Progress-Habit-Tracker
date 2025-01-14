import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key});

  final List<OrdinalData> ordinalDataList = [];

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();

    List<Habit> habits = habitProvider.habits;

    List<Habit> todayHabits = [];
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
      ordinalDataList.add(
        OrdinalData(
          domain: AppLocalizations.of(context)!.pieChartData,
          measure: 100,
          color: Colors.grey,
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            AppLocalizations.of(context)!.pieChartTitle,
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
