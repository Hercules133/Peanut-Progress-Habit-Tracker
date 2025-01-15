import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';

/// A custom TabBar widget to display categories for navigation.
///
/// The TabBar adapts to show only relevant categories based on whether the user
/// wants to see today's habits or all habits.
class MyTabBar extends StatelessWidget {
  /// Creates a TabBar widget.
  ///
  /// The [isScrollable] parameter determines if the tabs can be scrolled horizontally.
  /// The [showTodayOnly] parameter filters the categories to display only those
  /// with pending habits for the current day.
  const MyTabBar({
    super.key,
    this.isScrollable = true,
    this.showTodayOnly = true,
  });

  /// Whether the TabBar should be scrollable.
  final bool isScrollable;

  /// Whether to show only categories with habits due today.
  final bool showTodayOnly;

  @override
  Widget build(BuildContext context) {
    /// Fetches the current state of categories and habits from the respective providers.
    final categoryProvider = context.watch<CategoryProvider>();
    final habitProvider = context.watch<HabitProvider>();

    /// Retrieves the list of all categories from the [CategoryProvider].
    List<Category> allCategories = categoryProvider.categories;

    /// Filters the categories based on whether they have pending habits for today.
    List<Category> filteredCategories = allCategories.where((category) {
      // Exclude the 'All' category from filtering.
      if (showTodayOnly && category.name != 'All') {
        return habitProvider
            .getPendingHabitsForTodayByCategory(category)
            .isNotEmpty;
      }
      return true;
    }).toList();

    /// Retrieves the custom theme colors for the app.
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    /// Returns the TabBar widget with customized appearance and behavior.
    return TabBar(
      /// Adds a bouncing scroll effect for a smoother user experience.
      physics: const BouncingScrollPhysics(),

      /// Determines whether the tabs can be scrolled horizontally.
      isScrollable: isScrollable,

      /// Removes any background overlay effect when a tab is pressed.
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),

      /// Sets the text color of the selected tab.
      labelColor: ownColors.habitText,

      /// Sets the text color of the unselected tabs.
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,

      /// Removes any padding around the tabs.
      padding: EdgeInsets.zero,

      /// Removes padding around the tab indicators.
      indicatorPadding: EdgeInsets.zero,

      /// Hides the default tab indicator.
      indicatorColor: Colors.transparent,

      /// Removes padding around the tab labels.
      labelPadding: EdgeInsets.zero,

      /// Ensures no visible dividers between tabs.
      dividerColor: Colors.transparent,

      /// Updates the selected index in the [CategoryProvider] when a tab is tapped.
      onTap: (index) {
        categoryProvider.updateSelectedIndex(index);
      },

      /// Generates the tab widgets based on the filtered categories.
      tabs: List.generate(
        filteredCategories.length,
            (index) => Container(
          decoration: BoxDecoration(
            /// Adds rounded corners to each tab for a smoother look.
            borderRadius: BorderRadius.circular(16),

            /// Sets the background color of the tab based on the category's color.
            color: filteredCategories[index].color,
          ),
          /// Adds some spacing around each tab for a better layout.
          margin: const EdgeInsets.all(2),
          child: Tab(
            /// Adds padding inside each tab for better spacing of its contents.
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  /// Displays a checkmark icon if the tab is the currently selected tab.
                  if (index == categoryProvider.selectedIndex)
                    Icon(Icons.check),

                  /// Displays the category's icon.
                  Icon(filteredCategories[index].icon),

                  /// Displays the category's name as text.
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
