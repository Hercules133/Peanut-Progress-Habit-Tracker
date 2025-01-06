import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});
  List<TimeData> series1 = [];

  // Idee:
  // Letzte zehn wochen (Streak <= 10 bei eine habit)
  // Jede woche anzeigen wie viele habits erledigt (wenn habit bei streak 6 ist,
  // dann die letzte 6 wochen counter + 1. Wenn ein habit auf streak 4 ist, dann die letzte 4 wochen
  // auf 2 erhöhen, woche 5 und 6 bleibt auf 1 usw.)

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    List<Habit> habits = habitProvider.habits;

    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(Duration(days: 70));

    List<int> weekCounts = List.filled(10, 0);

    for (Habit habit in habits) {
      int streak = habit.streak;
      for (int i = 0; i < streak && i < 10; i++) {
        int weekIndex = 9 - i;
        weekCounts[weekIndex]++;
      }
    }

    for (int i = 0; i < 10; i++) {
      DateTime weekStart = endDate.subtract(Duration(days: 7 * (9 - i)));
      series1.add(TimeData(
        domain: weekStart,
        measure: weekCounts[i].toDouble(),
      ));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text(
            'Completed habits in the last 10 weeks (all categories, per week)',
            textAlign: TextAlign.center,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: DChartLineT(
            configRenderLine: ConfigRenderLine(
              strokeWidthPx: 2.5,
            ),
            layoutMargin: LayoutMargin(40, 10, 20, 10),
            domainAxis: DomainAxis(
              showLine: false,
              tickLength: 0,
              gapAxisToLabel: 10,
              tickLabelFormatterT: (domain) {
                return DateFormat('MMM d').format(domain);
              },
              labelStyle: const LabelStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            measureAxis: MeasureAxis(
              useGridLine: true,
              gridLineStyle: LineStyle(
                color: Colors.grey.shade200,
              ),
              numericTickProvider: const NumericTickProvider(
                desiredMinTickCount: 6,
                desiredMaxTickCount: 10,
              ),
              tickLength: 0,
              gapAxisToLabel: 10,
              tickLabelFormatter: (measure) {
                return measure!.toInt().toString().padLeft(2, '0');
              },
              labelStyle: const LabelStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            groupList: [
              TimeGroup(
                id: '1',
                data: series1,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
