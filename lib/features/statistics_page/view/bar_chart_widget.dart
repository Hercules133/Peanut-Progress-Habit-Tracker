import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';

class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});

  final List<OrdinalData> ordinalDataList = [];

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    List<Habit> habits = habitProvider.habits;

    List<int> habitCounts = List.filled(7, 0);
    List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (Habit habit in habits) {
      for (DayOfWeek day in habit.days) {
        int index = day.index;
        habitCounts[index]++;
      }
    }

    for (int i = 0; i < 7; i++) {
      ordinalDataList.add(OrdinalData(
        domain: daysOfWeek[i],
        measure: habitCounts[i].toDouble(),
      ));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text(
            'How many created habits on a day (all categories)',
            textAlign: TextAlign.center,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: DChartBarO(
            configRenderBar: ConfigRenderBar(
              barGroupInnerPaddingPx: 0,
              radius: 25,
            ),
            domainAxis: const DomainAxis(
              showLine: false,
              tickLength: 0,
              gapAxisToLabel: 8,
              labelStyle: LabelStyle(
                color: Colors.white,
              ),
            ),
            measureAxis: const MeasureAxis(
              noRenderSpec: true,
            ),
            groupList: [
              OrdinalGroup(id: '1', data: ordinalDataList, color: Colors.brown),
            ],
          ),
        ),
      ],
    );
  }
}
