import 'package:flutter/material.dart';
import 'package:peanutprogress/features/statistics_page/view/bar_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/line_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/pie_chart_widget.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/core/widgets/drawer_menu_widget.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A screen widget that displays various statistics related to habits.
///
/// The [StatisticsPage] class displays multiple charts to visualize habit statistics, including a heat map,
/// a pie chart of completed habits per category for today, a bar chart of created habits by day of the week,
/// and a line chart of habits completed in the last 10 weeks.
///
/// This page adjusts its layout for larger screens, showing charts side by side, and for smaller screens, stacking charts vertically.
///
/// ### Parameters:
/// - This widget takes no additional parameters.
///
/// This page uses the following custom widgets:
/// - [MyAppBar] for the app bar.
/// - [MyDrawerMenu] for the navigation drawer.
/// - [MyHeatMap] for the heat map.
/// - [PieChartWidget] for the pie chart.
/// - [BarChartWidget] for the bar chart.
/// - [LineChartWidget] for the line chart.
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
