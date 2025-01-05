import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

// ignore: must_be_immutable
class BarChartWidget extends StatelessWidget {
  BarChartWidget({super.key});
  List<OrdinalData> series1 = [
    OrdinalData(domain: 'Mon', measure: 2.4, color: Colors.white),
    OrdinalData(domain: 'Tue', measure: 2, color: Colors.white),
    OrdinalData(domain: 'Wed', measure: 1, color: Colors.white),
    OrdinalData(domain: 'Thu', measure: 4.5, color: Colors.white),
    OrdinalData(domain: 'Fri', measure: 2, color: Colors.white),
    OrdinalData(domain: 'Sat', measure: 3.5, color: Colors.white),
    OrdinalData(domain: 'Sun', measure: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBarO(
        configRenderBar: ConfigRenderBar(
          barGroupInnerPaddingPx: 0,
          radius: 15,
        ),
        domainAxis: const DomainAxis(
          showLine: false,
          tickLength: 0,
          gapAxisToLabel: 8,
        ),
        measureAxis: const MeasureAxis(
          noRenderSpec: true,
        ),
        groupList: [
          OrdinalGroup(
            id: '1',
            data: series1,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
