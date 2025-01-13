import 'package:flutter/material.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import '/core/utils/routes.dart';
import '/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A custom drawer menu widget that displays the app drawer menu.
///
/// This widget navigates to the respective pages when the menu items are tapped.
/// It uses the [categoryProvider] and [habitProvider] to reset the selected index and search status.
///
/// The Widget is wrapped in a [SafeArea] widget to avoid overlapping with the system UI.

class MyDrawerMenu extends StatelessWidget {
  const MyDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final habitProvider = context.watch<HabitProvider>();
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(AppLocalizations.of(context)!.drawerMenuHome),
              onTap: () {
                categoryProvider.resetSelectedIndex();
                habitProvider.isSearching = false;
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage('assets/images/Erdnuss.png'),
              ),
              title: Text(AppLocalizations.of(context)!.drawerMenuHabits),
              onTap: () {
                categoryProvider.resetSelectedIndex();
                habitProvider.isSearching = false;
                Navigator.pushReplacementNamed(context, Routes.habits);
              },
            ),
            ListTile(
              leading: const Icon(Icons.signal_cellular_alt),
              title: Text(AppLocalizations.of(context)!.drawerMenuStatistics),
              onTap: () {
                habitProvider.isSearching = false;
                Navigator.pushReplacementNamed(context, Routes.statistics);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.drawerMenuSettings),
              onTap: () {
                habitProvider.isSearching = false;
                Navigator.pushReplacementNamed(context, Routes.settings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('Hilfe'),
              onTap: () {
                Navigator.pushNamed(context, Routes.walkthrough);
              },
            ),
          ],
        ),
      ),
    );
  }
}
