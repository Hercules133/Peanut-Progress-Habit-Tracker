import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A widget that displays a bar chart of created habits by day of the week.
///
/// The [BarChartWidget] class shows a bar chart that visualizes the number of created habits for each day of the week.
///
/// ### Parameters:
/// - This widget takes no additional parameters.
///
/// This bar chart uses [OrdinalData] to plot the data and [DChartBarO] to render the chart.
class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  List<OrdinalData> ordinalDataList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() {
    final habitProvider = context.read<HabitProvider>();
    List<Habit> habits = habitProvider.habits;

    List<int> habitCounts = List.filled(7, 0);
    List<String> daysOfWeek = [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday
    ];

    for (Habit habit in habits) {
      for (DayOfWeek day in habit.days) {
        int index = day.index;
        habitCounts[index]++;
      }
    }

    setState(() {
      ordinalDataList = List.generate(7, (index) {
        return OrdinalData(
          domain: daysOfWeek[index],
          measure: habitCounts[index].toDouble(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            AppLocalizations.of(context)!.barChartTitle,
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
