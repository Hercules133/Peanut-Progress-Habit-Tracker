import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/core/widgets/details_dialog_widget.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A custom widget that displays the content of the currently selected tab in a TabBar.
///
/// The widget builds a [TabBarView] that shows different lists of habits based on the
/// selected category and the [showTodayOnly] flag.
class MyTabBarView extends StatelessWidget {
  /// Creates a TabBarView widget.
  ///
  /// The [showTodayOnly] parameter determines whether to show only today's habits or all habits.
  const MyTabBarView({
    super.key,
    this.showTodayOnly = true,
  });

  /// Flag to determine if only today's habits should be displayed.
  final bool showTodayOnly;

  @override
  Widget build(BuildContext context) {
    /// Fetches the current state of habits and categories from the respective providers.
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();

    /// Retrieves the custom theme colors for the app.
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    // Show filtered habits when search is active.
    if (habitProvider.isSearching) {
      final filteredHabits = habitProvider.habits;
      return buildGridView(filteredHabits, ownColors);
    }

    // Show a loading indicator if data is still being loaded.
    if (habitProvider.isLoading || categoryProvider.categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show a message if no habits are available.
    if (habitProvider.habits.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.myTabBarViewNoHabitsAvailable),
      );
    }

    /// Filters categories to only show those that have habits due today.
    final filteredCategories = [
      // Always include the "All" category.
      categoryProvider.categories.firstWhere((cat) => cat.name == 'All'),
      // Include other categories only if they have habits due today.
      ...categoryProvider.categories.where((category) {
        if (category.name == 'All') return false;
        final habits = showTodayOnly
            ? habitProvider.getPendingHabitsForTodayByCategory(category)
            : habitProvider.getHabitsByCategory(category);
        return habits.isNotEmpty;
      }),
    ];

    // Show a message if no categories have habits for today.
    if (filteredCategories.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.myTabBarViewNoHabitsForToday),
      );
    }

    /// Builds a [TabBarView] with content for each filtered category.
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

        // Return an empty widget if no habits are available for today.
        if (showTodayOnly && habits.isEmpty) return const SizedBox.shrink();

        // Build a grid view of habits for the category.
        return buildGridView(habits, ownColors, category.color);
      }).toList(),
    );
  }

  /// Builds a grid view to display a list of habits.
  ///
  /// The grid adjusts its layout based on the screen size, showing more columns on wider screens.
  /// Each habit is displayed as a card with details such as title, streak, and completion status.
  Widget buildGridView(List<Habit> habits, OwnColors ownColors, [Color? color]) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Determines the number of columns in the grid based on screen width.
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1000) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }

        /// Filters out completed habits if [showTodayOnly] is true.
        final visibleHabits = showTodayOnly
            ? habits
            .where((habit) => !habit.isCompletedOnDate(DateTime.now()))
            .toList()
            : habits;

        /// Builds the grid view using a [GridView.builder].
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
                  /// Button to toggle the completion status of the habit.
                  leading: IconButton(
                    icon: SizedBox(
                      width: 40,
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
                  /// Displays the title of the habit.
                  title: Text(habit.title),
                  /// Displays the streak and time of the habit.
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
                  /// Opens a dialog with more details about the habit when tapped.
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
