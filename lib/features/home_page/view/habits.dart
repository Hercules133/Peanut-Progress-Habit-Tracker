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

  static const List<String> categoriesName = <String>[
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
    'Category 6',
    'Category 7',
    'Category 8',
    'Category 9',
    'Category 10'
  ];

  static String _sortBy = 'Alle';

  @override
  Widget build(BuildContext context) {
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
                    child: MyTabBar(),
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

  // ignore: unused_element
  Widget _buildSortOption(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        selected: _sortBy == label,
        onSelected: (bool selected) {
          _sortBy = label;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
