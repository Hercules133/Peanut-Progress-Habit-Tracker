import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

// ignore: must_be_immutable
class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});
  List<OrdinalData> series1 = [
    OrdinalData(domain: 'Mon', measure: 2.4),
    OrdinalData(domain: 'Tue', measure: 2),
    OrdinalData(domain: 'Wed', measure: 1),
    OrdinalData(domain: 'Thu', measure: 4.5),
    OrdinalData(domain: 'Fri', measure: 2),
    OrdinalData(domain: 'Sat', measure: 3.5),
    OrdinalData(domain: 'Sun', measure: 2),
  ];
  List<OrdinalData> series2 = [
    OrdinalData(domain: 'Mon', measure: 3),
    OrdinalData(domain: 'Tue', measure: 1.8),
    OrdinalData(domain: 'Wed', measure: 4),
    OrdinalData(domain: 'Thu', measure: 3),
    OrdinalData(domain: 'Fri', measure: 6),
    OrdinalData(domain: 'Sat', measure: 5),
    OrdinalData(domain: 'Sun', measure: 3.5),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBarO(
        configRenderBar: ConfigRenderBar(
          barGroupInnerPaddingPx: 0,
          radius: 30,
        ),
        domainAxis: const DomainAxis(
          showLine: false,
          tickLength: 0,
          gapAxisToLabel: 12,
        ),
        measureAxis: const MeasureAxis(
          noRenderSpec: true,
        ),
        groupList: [
          OrdinalGroup(
            id: '1',
            data: series1,
            color: Colors.amber,
          ),
          OrdinalGroup(
            id: '2',
            data: series2,
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
