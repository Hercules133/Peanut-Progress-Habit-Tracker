import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final weeksToShow = ((screenWidth - 18) / 20).floor();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF734D2F),
      ),
      child: HeatMap(
        textColor: const Color(0xFFC5CACD),
        colorMode: ColorMode.color,
        colorTipHelper: const [
          Text('0% ',
              style: TextStyle(
                color: Color(0xFFC5CACD),
              )),
          Text(
            ' 100% ',
            style: TextStyle(
              color: Color(0xFFC5CACD),
            ),
          )
        ],
        scrollable: true,
        size: 15,
        defaultColor: const Color.fromARGB(255, 129, 93, 58),
        endDate: DateTime.now().add(Duration(days: 6 - DateTime.now().weekday)),
        startDate: DateTime.now()
            .subtract(Duration(days: DateTime.daysPerWeek * (weeksToShow - 1))),
        datasets: m,
        colorTipCount: 5,
        colorsets: const {
          0: Color(0xFFDBDBDB),
          1: Color(0xFFD3B09C),
          25: Color(0xFFD6916B),
          50: Color(0xFFFB7F3C),
          75: Color(0xFFFD6D24),
          100: Color(0xFFFF5A00),
        },
      ),
    );
  }
}

Map<DateTime, int> m = {
  DateTime(2024, 11, 29): 0,
  DateTime(2024, 11, 28): 10,
  DateTime(2024, 11, 27): 30,
  DateTime(2024, 11, 26): 52,
  DateTime(2024, 11, 24): 100,
  DateTime(2024, 11, 25): 80,
  DateTime(2024, 11, 23): 90
};
