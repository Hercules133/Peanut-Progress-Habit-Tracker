import 'package:flutter/material.dart';
import 'package:peanutprogress/features/statistics_page/view/bar_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/line_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/pie_chart_widget.dart';
import '/core/widgets/app_bar_widget.dart';
import '/core/widgets/drawer_menu_widget.dart';
import '/features/home_page/view/heat_map_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBar: AppBar(),
        appBarTitle: AppLocalizations.of(context)!.statisticsPageAppBarTitle,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: const MyHeatMap(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: PieChartWidget(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: BarChartWidget(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LineChartWidget(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text("Heatmap"),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: const MyHeatMap(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: PieChartWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BarChartWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LineChartWidget(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
