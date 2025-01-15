import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({
    super.key,
    this.isScrollable = true,
    this.showTodayOnly = true,
  });

  final bool isScrollable;
  final bool showTodayOnly;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final habitProvider = context.watch<HabitProvider>();
    List<Category> allCategories = categoryProvider.categories;
    List<Category> filteredCategories = allCategories.where((category) {
      if (showTodayOnly && category.name != 'All') {
        return habitProvider
            .getPendingHabitsForTodayByCategory(category)
            .isNotEmpty;
      }
      return true;
    }).toList();

    final ownColors = Theme.of(context).extension<OwnColors>()!;

    return TabBar(
      physics: const BouncingScrollPhysics(),
      isScrollable: isScrollable,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      labelColor: ownColors.habitText,
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      onTap: (index) {
        categoryProvider.updateSelectedIndex(index);
      },
      tabs: List.generate(
        filteredCategories.length,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: filteredCategories[index].color,
          ),
          margin: const EdgeInsets.all(2),
          child: Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (index == categoryProvider.selectedIndex)
                    Icon(Icons.check),
                  Icon(filteredCategories[index].icon),
                  Text(filteredCategories[index].name),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
