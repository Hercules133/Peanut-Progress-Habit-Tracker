import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final monthsToShow = (screenWidth / 90).floor();
    return Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFB8936D),
        ),
        child: HeatMap(
          textColor: const Color(0xFFC5CACD),
          colorMode: ColorMode.color,
          colorTipHelper: const [
            Text('0% ',
                style: TextStyle(
                  color: const Color(0xFFC5CACD),
                )),
            Text(
              ' 100% ',
              style: TextStyle(
                color: const Color(0xFFC5CACD),
              ),
            )
          ],
          scrollable: true,
          size: 15,
          defaultColor: const Color(0xFFDBDBDB),
          startDate: DateTime(DateTime.now().year,
              DateTime.now().month - monthsToShow, DateTime.now().day),
          endDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 7),
          datasets: m,
          colorTipCount: 4,
          colorsets: const {
            0: Color(0xFFD3B09C),
            1: Color(0xFFD6916B),
            2: Color(0xFFFB7F3C),
            3: Color(0xFFFF5A00),
          },
        ));
  }
}

Map<DateTime, int> m = {
  DateTime(2024, 11, 18): 1,
  DateTime(2024, 11, 20): 2,
  DateTime(2024, 11, 23): 3
};
