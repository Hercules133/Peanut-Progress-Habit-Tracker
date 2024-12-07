import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/widgets/details_dialog_widget.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    final allCategories = categoryProvider.categories;

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
              textColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              leading: IconButton(
                icon: Image.asset('assets/images/Erdnuss.png'),
                onPressed: () => {},
              ),
              title: Text(habit.title),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(habit.streak.toString(),
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(width: 5),
                      SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ],
                  ),
                  Text(habit.time.format(context),
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              onTap: () {
                showDetailsDialog(context, habit);
              },
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 5),
      );
    }

    // Standardansicht: Habits nach Kategorien
    return TabBarView(
      children: allCategories.map((category) {
        final pendingHabits =
        habitProvider.getPendingHabitsByCategory(category);

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          itemCount: pendingHabits.length,
          itemBuilder: (context, idx) {
            final habit = pendingHabits[idx];

            return Card(
              color: category.color,
              child: ListTile(
                textColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                leading: IconButton(
                  icon: Image.asset('assets/images/Erdnuss.png'),
                  onPressed: () => {},
                ),
                title: Text(habit.title),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(habit.streak.toString(),
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 5),
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ],
                    ),
                    Text(habit.time.format(context),
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () {
                  showDetailsDialog(context, habit);
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