import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Guten Morgen!'),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
              icon: Image.asset('assets/images/logo.png'), onPressed: () {}),
        ],
      ),
      drawer: Drawer(child: ListView() // Populate the Drawer in the last step.
          ),
      body: Align(
        alignment: Alignment.topCenter,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                const Expanded(
                  child: HeatMap(
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
                  ),
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
