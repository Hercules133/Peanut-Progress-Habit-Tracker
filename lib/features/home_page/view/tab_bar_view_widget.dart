import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/widgets/details_dialog_widget.dart';
import 'package:streaks/data/models/own_colors.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';

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

    //TODO Doppelter code in private Methode auslagern, kein koppelten code.
    // Wenn Suche aktiv ist, werden gefilterte Habits angezeigt
    if (habitProvider.isSearching) {
      final filteredHabits = habitProvider.habits; // Gefilterte Habits

      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        itemCount: filteredHabits.length,
        itemBuilder: (context, idx) {
          final habit = filteredHabits[idx];
          return Card(
            color: habit.category.color,
            child: ListTile(
              textColor: ownColors.habitText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: IconButton(
                icon: SizedBox(
                  width: 40, // Feste Breite für das Icon
                  child: habit.isCompletedOnDate(DateTime.now())
                      ? Image.asset('assets/images/Erdnusse.png')
                      : Image.asset('assets/images/Erdnuss.png'),
                ),
                onPressed: () {
                  habitProvider.toggleHabitComplete(habit, DateTime.now());
                },
              ),
              title: Text(habit.title),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(habit.streak.toString(),
                          style: TextStyle(
                            color: ownColors.habitText,
                          )),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ],
                  ),
                  Text(habit.time.format(context),
                      style: TextStyle(
                        color: ownColors.habitText,
                      )),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => HabitDetailsDialog(habit: habit),
                );
              },
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 5),
      );
    }

    if (habitProvider.isLoading || categoryProvider.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (habitProvider.habits.isEmpty) {
      return const Center(child: Text('No habits available.'));
    }

    // Standardansicht: Habits nach Kategorien
    return TabBarView(
      children: allCategories.map((category) {
        final habits = showTodayOnly
            ? habitProvider.getPendingHabitsForTodayByCategory(category) // Home-Seite
            : habitProvider.getHabitsByCategory(category); // Habits-Seite

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          itemCount: habits.length,
          itemBuilder: (context, idx) {
            final habit = habits[idx];
            return Card(
              color: category.color,
              child: ListTile(
                textColor: ownColors.habitText,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                leading: IconButton(
                  icon: SizedBox(
                    width: 40, // Feste Breite für das Icon
                    child: habit.isCompletedOnDate(DateTime.now())
                        ? Image.asset('assets/images/Erdnusse.png')
                        : Image.asset('assets/images/Erdnuss.png'),
                  ),
                  onPressed: () {
                    habitProvider.toggleHabitComplete(habit, DateTime.now());
                  },
                ),
                title: Text(habit.title),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(habit.streak.toString(),
                            style: TextStyle(
                              color: ownColors.habitText,
                            )),
                        const SizedBox(width: 5),
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ],
                    ),
                    Text(habit.time.format(context),
                        style: TextStyle(
                          color: ownColors.habitText,
                        )),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => HabitDetailsDialog(habit: habit),
                  );
                },
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 5),
        );
      }).toList(),
    );
  }
}
