import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/features/create_habit/view/create_habit_form_widget.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    this.isScrollable = true,
  });

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
    final categoryProvider = context.watch<CategoryProvider>();
    print("Es existieren ${categoryProvider.categories.length} Kategorien.");
    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.black, 
          width: 2.0,),
      ),
      labelColor: Colors.white,
      unselectedLabelColor: const Color.fromARGB(255, 183, 182, 180),
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      tabs: List.generate(
        categoryProvider.categories.length,
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
                  Text(categoryProvider.categories[index].name)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
