import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: List.generate(
        tabs.length,
        (tab) => ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (BuildContext context, int idx) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: categoryColor[tab],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/Erdnuss.png'),
                      onPressed: () => {},
                    ),
                    Text(
                      'Habit $idx of ${tabs[tab]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '20',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Container(
                                height: 30,
                                child: Image.asset('assets/images/logo.png')),
                          ],
                        ),
                        Text('18:00', style: TextStyle(color: Colors.white),)
                      ],
                    ), 
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                )),
      ),
    );
  }
}
