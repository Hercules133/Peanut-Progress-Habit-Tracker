import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/core/widgets/details_dialog_widget.dart';

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    super.key,
    required this.tabs,
  });

  final List<String> tabs;

  static const List<Color> categoryColor = [
    Color.fromARGB(255, 146, 93, 53),
    Color.fromARGB(255, 118, 72, 36),
    Color.fromARGB(255, 142, 93, 30),
    Color.fromARGB(255, 133, 64, 11),
    Color.fromARGB(255, 94, 63, 2),
    Color.fromARGB(255, 70, 41, 9),
    Color.fromARGB(255, 89, 54, 12),
    Color.fromARGB(255, 159, 89, 28),
    Color.fromARGB(255, 163, 88, 27),
    Color.fromARGB(255, 199, 116, 57),
  ];

  static Habit test_habit = Habit(
      title: "Lunch",
      description: "Cook and eat lunch",
      days: [0, 1, 4],
      time: const TimeOfDay(hour: 12, minute: 30),
      category: Category(
          name: 'Eating', color: '#ec664a', icon: const Icon(Icons.adobe)));

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: List.generate(
        tabs.length,
        (tab) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (BuildContext context, int idx) {
            return ListTile(
              tileColor: categoryColor[tab],
              textColor: Colors.white,
              contentPadding: const EdgeInsets.only(
                  left: 10.0, top: 2.0, bottom: 2.0, right: 10.0),
              minVerticalPadding: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: IconButton(
                icon: Image.asset('assets/images/Erdnuss.png'),
                onPressed: () => {},
              ),
              title: Text('Habit $idx of ${tabs[tab]}'),
              trailing: Wrap(
                direction: Axis.vertical,
                children: [
                  Row(
                    children: [
                      Text(
                        '20',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Container(
                        height: 30,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ],
                  ),
                  Text(
                    '18:00',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              onTap: () {
                showDetailsDialog(context, test_habit);
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
        ),
      ),
    );
  }
}
