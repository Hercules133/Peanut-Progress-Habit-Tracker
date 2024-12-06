import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/ownColors.dart';
import 'package:streaks/data/models/heatmap.dart' as hm;
import 'package:streaks/data/providers/habit_provider.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final weeksToShow = ((screenWidth - 18) / 20).floor();
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    final provider = Provider.of<HabitProvider>(context);
    
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
        colorTipHelper:  [
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
        datasets: hm.HeatMap.generateHeatMapData(provider),
        colorTipCount: 5,
        colorsets: {
          0: ownColors.contribution0, //Color(0xFFDBDBDB),
          1: ownColors.contribution1, //Color(0xFFD3B09C),
          25: ownColors.contribution2, //Color(0xFFD6916B),
          50: ownColors.contribution3, //Color(0xFFFB7F3C),
          75: ownColors.contribution4, //Color(0xFFFD6D24),
          100: ownColors.contribution5, //Color(0xFFFF5A00),
        },
      ),
    );
  }
}
