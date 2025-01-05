import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/habit_provider.dart';
import '/core/utils/routes.dart';
import '/data/providers/category_provider.dart';
import '../../../core/widgets/app_bar_widget.dart';
import '/core/widgets/drawer_menu_widget.dart';
import '/core/utils/get_greeting.dart';
import 'heat_map_widget.dart';
import 'tab_bar_widget.dart';
import 'tab_bar_view_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    HabitProvider habitProvider = context.watch<HabitProvider>();

    final filteredCategories = [
      categoryProvider.categories.firstWhere((cat) => cat.name == 'All'),
      ...categoryProvider.categories.where((category) {
        if (category.name == 'All') return false;
        return habitProvider.getPendingHabitsForTodayByCategory(category).isNotEmpty;
      }),
    ];

    return DefaultTabController(
      length: filteredCategories.length,
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
          appBarTitle: getGreeting(),
        ),
        drawer: const MyDrawerMenu(),
        body: const Column(
          children: [
            MyHeatMap(),
            MyTabBar(showTodayOnly: true),
            Expanded(
              child: MyTabBarView(showTodayOnly: true),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.add);
            },
            tooltip: 'new Habit',
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
      ),
    );
  }
}
