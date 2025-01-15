import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/core/widgets/drawer_menu_widget.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_widget.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_view_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        return habitProvider
            .getPendingHabitsForTodayByCategory(category)
            .isNotEmpty;
      }),
    ];

    return DefaultTabController(
      length: filteredCategories.length,
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
          appBarTitle: getGreeting(context),
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
            tooltip: AppLocalizations.of(context)!.myHomePageNewHabitTooltip,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSurface,
            )),
      ),
    );
  }
}
