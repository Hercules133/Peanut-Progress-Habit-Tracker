import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_view_widget.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_widget.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:peanutprogress/core/widgets/drawer_menu_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A stateless widget representing the habits page.
///
/// This page displays user-defined habits organized by categories. It includes a
/// search functionality and navigation to create new habits.
class MyHabitsPage extends StatelessWidget {
  /// Constructor for the MyHabitsPage widget.
  const MyHabitsPage({super.key});

  /// Builds the widget tree for the Habits page.
  ///
  /// The widget includes:
  /// - An [AppBar] with a greeting title.
  /// - A [Drawer] for navigation to other sections.
  /// - A [TabBar] and [TabBarView] for navigating categories and displaying habits.
  /// - A [FloatingActionButton] for creating new habits.
  @override
  Widget build(BuildContext context) {
    // Watch providers to get the latest state of habits and categories.
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();

    // DefaultTabController manages the state of the TabBar and TabBarView.
    return DefaultTabController(
      length: categoryProvider.categories.length,
      child: Scaffold(
        /// App bar containing a dynamic greeting message based on the time of day.
        appBar: MyAppBar(
          appBar: AppBar(),
          appBarTitle: getGreeting(context),
        ),

        /// Drawer menu providing navigation options to different sections of the app.
        drawer: const MyDrawerMenu(),

        /// The body of the page, containing the TabBar and the TabBarView.
        body: Column(
          children: [
            // Top row containing the TabBar and a search button.
            Row(
              children: [
                if (!habitProvider.isSearching) ...[
                  /// The TabBar allows users to switch between different categories.
                  const Expanded(
                    child: MyTabBar(showTodayOnly: false),
                  ),
                  /// Search button to toggle the search field.
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => habitProvider.toggleSearch(),
                  ),
                ] else ...[
                  /// TextField for searching habits, shown when search mode is active.
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Suche nach Habits...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => habitProvider.toggleSearch(),
                        ),
                      ),
                      // Updates the search query in the HabitProvider.
                      onChanged: (value) => habitProvider.updateQuery(value),
                    ),
                  ),
                ],
              ],
            ),
            /// The TabBarView displays the habits based on the selected category.
            const Expanded(
              child: MyTabBarView(showTodayOnly: false),
            ),
          ],
        ),

        /// Floating action button to navigate to the habit creation screen.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.add);
          },
          tooltip: AppLocalizations.of(context)!.myHabitPageNewHabitTooltip,
          shape: const CircleBorder(),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
