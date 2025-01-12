import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<OrdinalData> ordinalDataList = [];

  void loadData() {
    final habitProvider = context.read<HabitProvider>();
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
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
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
            configRenderBar: const ConfigRenderBar(
              radius: 25,
            ),
            domainAxis: DomainAxis(
              showLine: false,
              lineStyle: LineStyle(color: Colors.grey.shade200),
              tickLength: 0,
              gapAxisToLabel: 12,
              labelStyle: const LabelStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            measureAxis: const MeasureAxis(
              gapAxisToLabel: 8,
              numericTickProvider: NumericTickProvider(
                desiredMinTickCount: 5,
                desiredMaxTickCount: 10,
              ),
              tickLength: 0,
              labelStyle: LabelStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            groupList: [
              OrdinalGroup(
                id: '1',
                data: ordinalDataList,
                color: Colors.brown,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
