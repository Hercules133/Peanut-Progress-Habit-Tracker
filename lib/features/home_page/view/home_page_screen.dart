import 'package:flutter/material.dart';
import 'package:streaks/core/utils/hexcolor.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/data/models/category.dart';

import 'app_bar_widget.dart';
import 'drawer_menu_widget.dart';
import 'heat_map_widget.dart';
import 'tab_bar_widget.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  Habit test_habit = Habit(
      title: "Lunch",
      description: "Cook and eat lunch",
      days: [0, 1, 4],
      time: TimeOfDay(hour: 12, minute: 30),
      habit_category: Habitcategory(
          name: 'Eating', color: '#ec664a', icon: Icon(Icons.adobe)));

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
        drawer: const MyDrawerMenu(),
        body: Column(
          children: [
            const MyHeatMap(),
            const MyTabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  myTabs.length,
                  (index) => Center(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(test_habit.title),
                                  trailing: Text('${test_habit.streak}'),
                                  onTap: () {
                                    showDetailsDialog(context, test_habit);
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'new Habit',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> showDetailsDialog(BuildContext context, Habit habit) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: ListTile(
              title: Text(
                habit.title,
                style: TextStyle(fontSize: 25),
              ),
              leading: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/Erdnuss.png')),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  '${habit.streak}',
                  style: TextStyle(fontSize: 12),
                ),
                IconButton(
                  icon: Image.asset('assets/images/logo.png'),
                  onPressed: () {},
                ),
              ])),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyHeatMap(),
                Text(
                  habit.description,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${habit.time.hour}:${habit.time.minute}'),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HexColor(habit.habit_category.color),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0), // Mehr Platz
                    child: Row(
                      children: [
                        habit.habit_category.icon,
                        Text(habit.habit_category.name),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // this has to take us to the edit page later
                  },
                  child: Icon(Icons.edit),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
