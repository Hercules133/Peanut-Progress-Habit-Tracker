import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/create_habit_screen.dart';

import 'app_bar_widget.dart';
import 'drawer_menu_widget.dart';
import 'heat_map_widget.dart';
import 'tab_bar_widget.dart';
import 'tab_bar_view_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const List<String> categoriesName = <String>[
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 6',
    'Category 7',
    'Category 8',
    'Category 9',
    'Category 10'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoriesName.length,
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        drawer: const MyDrawerMenu(),
        body: const Column(
          children: [
            MyHeatMap(),
            MyTabBar(tabs: categoriesName),
            Expanded(
              child: MyTabBarView(tabs: categoriesName),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'new Habit',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
