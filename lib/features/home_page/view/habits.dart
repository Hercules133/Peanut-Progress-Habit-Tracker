import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/providers/category_provider.dart';
import '/data/providers/habit_provider.dart';
import '/features/home_page/view/tab_bar_view_widget.dart';
import '/features/home_page/view/tab_bar_widget.dart';
import '../../../core/widgets/app_bar_widget.dart';
import '/core/utils/get_greeting.dart';
import '/core/widgets/drawer_menu_widget.dart';

class MyHabitsPage extends StatelessWidget {
  const MyHabitsPage({super.key});

  static String _sortBy = 'Alle';

  @override
  Widget build(BuildContext context) {
    debugPrint("Hier ist die Habits-Seite!");
    final habitProvider = context.watch<HabitProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    return DefaultTabController(
      length: categoryProvider.categories.length,
      child: Scaffold(
        appBar: MyAppBar(
          appBar: AppBar(),
          appBarTitle: getGreeting(),
        ),
        drawer: const MyDrawerMenu(),
        body: Column(
          children: [
            // TabBar mit Such-Icon
            Row(
              children: [
                if (!habitProvider.isSearching) ...[
                  const Expanded(
                    child: MyTabBar(showTodayOnly: false),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => habitProvider.toggleSearch(),
                  ),
                ] else ...[
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
                      onChanged: (value) => habitProvider.updateQuery(value),
                    ),
                  ),
                ],
              ],
            ),
            // Gefilterte Habit-Ansicht
            const Expanded(
              child: MyTabBarView(showTodayOnly: false),
            ),
          ],
        ),
      ),
    );
  }
}
