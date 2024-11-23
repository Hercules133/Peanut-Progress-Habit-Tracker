import 'package:flutter/material.dart';

import 'app_bar_widget.dart';
import 'drawer_menu_widget.dart';
import 'heat_map_widget.dart';
import 'tab_bar_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const List<String> myTabs = <String>[
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
      length: myTabs.length,
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        drawer: MyDrawerMenu(),
        body: Column(
          children: [
            const Expanded(
              child: MyHeatMap(),
            ),
            const MyTabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  myTabs.length,
                  (index) => Center(
                    child: Text(myTabs[index]),
                  ),
                ),
              ),
              // children: myTabs.map((Tab tab) {
              //   final String label = tab.text!.toLowerCase();
              //   return Center(
              //     child: Text(
              //       'This is the $label tab',
              //       style: const TextStyle(fontSize: 36),
              //     ),
              //   );
              // }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}


