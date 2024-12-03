import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:streaks/features/home_page/view/tab_bar_view_widget.dart';
import 'package:streaks/features/home_page/view/tab_bar_widget.dart';
import '../../../core/widgets/app_bar_widget.dart';
import 'package:streaks/core/utils/get_greeting.dart';
import 'package:streaks/core/widgets/drawer_menu_widget.dart';
import 'tab_bar_widget.dart';
import 'package:streaks/core/utils/get_greeting.dart';
import 'package:streaks/data/models/colorscheme.dart';

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
    return DefaultTabController(
        length: categoriesName.length,
        child: Scaffold(
          appBar: MyAppBar(
            appBar: AppBar(),
            appBarTitle: getGreeting(),
          ),
          drawer: const MyDrawerMenu(),
          body: const Column(
            children: [
              MyTabBar(tabs: categoriesName),
              Expanded(
                child: MyTabBarView(tabs: categoriesName),
              )
            ],
          ),
        )
      );
    }

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