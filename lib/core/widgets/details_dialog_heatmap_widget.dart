import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/models/heatmap.dart' as hm;
import 'package:peanutprogress/data/models/habit.dart';

/// A custom heatmap widget that displays the heatmap for a single habit.
///
/// This widget visualizes the completion status of a habit over the last few weeks.
/// It uses a heatmap to represent the days on which the habit was completed or not completed.
///
/// The [habit] parameter is the habit for which the heatmap is displayed.
/// The number of weeks displayed is calculated based on the screen width.
class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    /// Calculates the number of weeks to show based on the screen width.
    ///
    /// The width of the Column with the weekdays in the heatmap is assumed 18.
    /// The width of a single column in the heatmap is assumed 20.
    final weeksToShow = ((screenWidth - 18) / 20)
        .floor(); //(screenWidth - widthWeekdays) / widthColumn
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: HeatMap(
        textColor: Theme.of(context).colorScheme.onSurface,
        colorMode: ColorMode.color,
        colorTipHelper: [
          Text('0% ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              )),
          Text(
            ' 100% ',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
        scrollable: true,
        size: 15,
        defaultColor: ownColors.contributionDefault,
        endDate: DateTime.now().add(
          Duration(days: (6 - DateTime.now().weekday) % 7),
        ),
        startDate: DateTime.now()
            .subtract(Duration(days: DateTime.daysPerWeek * (weeksToShow - 1))),
        datasets: hm.HeatMap.generateHeatMapForHabit(habit),
        colorTipCount: 2,
        colorsets: {
          0: ownColors.contribution0,
          1: ownColors.contribution5,
        },
      ),
    );
  }
}
