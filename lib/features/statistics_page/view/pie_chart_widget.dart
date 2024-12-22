import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

// ignore: must_be_immutable
class PieChartWidget extends StatelessWidget {
  PieChartWidget({super.key});
  List<OrdinalData> ordinalDataList = [
    OrdinalData(
      domain: 'A',
      measure: 60,
      color: Colors.blue,
    ),
    OrdinalData(
      domain: 'B',
      measure: 25,
      color: Colors.cyan,
    ),
    OrdinalData(
      domain: 'C',
      measure: 15,
      color: Colors.deepPurple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartPieO(
        data: ordinalDataList,
        customLabel: (ordinalData, index) {
          return '${ordinalData.measure}%';
        },
        configRenderPie: ConfigRenderPie(
          strokeWidthPx: 2,
          arcLabelDecorator: ArcLabelDecorator(),
        ),
      ),
    );
  }
}
