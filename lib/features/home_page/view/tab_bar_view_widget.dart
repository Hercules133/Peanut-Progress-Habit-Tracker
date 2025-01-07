import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/widgets/details_dialog_widget.dart';
import '/data/models/own_colors.dart';
import '/data/providers/category_provider.dart';
import '/data/providers/habit_provider.dart';
import '../../../data/models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    super.key,
    this.showTodayOnly = true,
  });

  final bool showTodayOnly;

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final allCategories = categoryProvider.categories;
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    if (habitProvider.isSearching) {
      final filteredHabits = habitProvider.habits;
      return buildGridView(filteredHabits, ownColors);
    }

    if (habitProvider.isLoading || categoryProvider.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (habitProvider.habits.isEmpty) {
      return Center(
          child: Text(
              AppLocalizations.of(context)!.myTabBarViewNoHabitsAvailable));
    }

    final filteredCategories = [
      categoryProvider.categories.firstWhere((cat) => cat.name == 'All'),
      ...categoryProvider.categories.where((category) {
        if (category.name == 'All') return false;
        final habits = showTodayOnly
            ? habitProvider.getPendingHabitsForTodayByCategory(category)
            : habitProvider.getHabitsByCategory(category);
        return habits.isNotEmpty;
      }),
    ];

    if (filteredCategories.isEmpty) {
      return Center(
          child:
              Text(AppLocalizations.of(context)!.myTabBarViewNoHabitsForToday));
    }

    return TabBarView(
      children: filteredCategories.map((category) {
        List<Habit> habits = [];
        if (category.name == 'All') {
          habits = showTodayOnly
              ? habitProvider.getPendingHabitsForToday()
              : habitProvider.getAllHabits();
        } else {
          habits = showTodayOnly
              ? habitProvider.getPendingHabitsForTodayByCategory(category)
              : habitProvider.getHabitsByCategory(category);
        }
        if (showTodayOnly && habits.isEmpty) return const SizedBox.shrink();
        return buildGridView(habits, ownColors, category.color);
      }).toList(),
    );
  }

  Widget buildGridView(List<Habit> habits, OwnColors ownColors,
      [Color? color]) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        final visibleHabits = showTodayOnly
            ? habits
                .where((habit) => !habit.isCompletedOnDate(DateTime.now()))
                .toList()
            : habits;

        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          itemCount: visibleHabits.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 3.87,
          ),
          itemBuilder: (context, idx) {
            final habit = visibleHabits[idx];
            return SizedBox(
              height: 150,
              child: Card(
                color: habit.category.color,
                child: ListTile(
                  textColor: ownColors.habitText,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  leading: IconButton(
                    icon: SizedBox(
                      width: 40, // Feste Breite für das Icon
                      child: habit.isCompletedOnDate(DateTime.now())
                          ? Image.asset('assets/images/Erdnusse.png')
                          : Image.asset('assets/images/Erdnuss.png'),
                    ),
                    onPressed: () {
                      context
                          .read<HabitProvider>()
                          .toggleHabitComplete(habit, DateTime.now());
                    },
                  ),
                  title: Text(habit.title),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            habit.streak.toString(),
                            style: TextStyle(
                              color: ownColors.habitText,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 30,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ],
                      ),
                      Text(
                        habit.time.format(context),
                        style: TextStyle(
                          color: ownColors.habitText,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => HabitDetailsDialog(habit: habit),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
