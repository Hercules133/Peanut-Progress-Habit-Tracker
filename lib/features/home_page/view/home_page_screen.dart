import 'package:flutter/material.dart';

import 'app_bar_widget.dart';
import 'heat_map_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBar: AppBar(),),
      drawer: Drawer(
        child: ListView()
          ),
      body: Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                const Expanded(
                  child: MyHeatMap(),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: myTabs,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: myTabs.map((Tab tab) {
                      final String label = tab.text!.toLowerCase();
                      return Center(
                        child: Text(
                          'This is the $label tab',
                          style: const TextStyle(fontSize: 36),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
