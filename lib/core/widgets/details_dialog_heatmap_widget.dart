import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:streaks/data/models/ownColors.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final weeksToShow = ((screenWidth - 18) / 20).floor();
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
        endDate: DateTime.now().add(Duration(days: 6 - DateTime.now().weekday)),
        startDate: DateTime.now()
            .subtract(Duration(days: DateTime.daysPerWeek * (weeksToShow - 1))),
        datasets: m,
        colorTipCount: 2,
        colorsets: {
          0: ownColors.contribution0,
          1: ownColors.contribution5,
        },
      ),
    );
  }
}

Map<DateTime, int> m = {
  DateTime(2024, 11, 18): 0,
  DateTime(2024, 11, 20): 1,
  DateTime(2024, 11, 23): 1
};
