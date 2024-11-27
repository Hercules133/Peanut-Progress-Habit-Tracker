import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    required this.tabs,
    this.isScrollable = true,
  });

  final List<String> tabs;
  final bool isScrollable;
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
    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: isScrollable,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 3.0)),
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        color: Colors.white,
      ),
      labelColor: Colors.white,
      unselectedLabelColor: const Color.fromARGB(255, 183, 182, 180),
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      tabs: List.generate(
        tabs.length,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: categoryColor[index],
          ),
          margin: const EdgeInsets.all(2),
          child: Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.info), 
                  Text(tabs[index])],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
