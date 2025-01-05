import 'package:flutter/material.dart';
import 'package:peanutprogress/features/statistics_page/view/bar_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/line_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/pie_chart_widget.dart';
import '/core/widgets/app_bar_widget.dart';
import '/core/widgets/drawer_menu_widget.dart';
import '/features/home_page/view/heat_map_widget.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        appBarTitle: 'Statistics',
      ),
      drawer: const MyDrawerMenu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: const MyHeatMap()),
                      Expanded(child: PieChartWidget()),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: BarChartWidget()),
                      Expanded(child: LineChartWidget()),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const MyHeatMap(),
                  const Text('Diagrams'),
                  PieChartWidget(),
                  BarChartWidget(),
                  LineChartWidget(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
