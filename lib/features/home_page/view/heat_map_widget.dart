import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget{  
  const MyHeatMap({super.key});


  @override
  Widget build(BuildContext context) {
    return const HeatMap(
                    scrollable: true,
                    // startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
                    // endDate: DateTime(DateTime.now().year, DateTime.now().month+3),
                    colorsets: {
                      1: Colors.red,
                      3: Colors.orange,
                      5: Colors.yellow,
                      7: Colors.green,
                      9: Colors.blue,
                      11: Colors.indigo,
                      13: Colors.purple,
                    },
                  );
  }

}
