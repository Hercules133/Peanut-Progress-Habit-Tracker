import 'package:flutter/material.dart';
import '/core/utils/routes.dart';
import '/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawerMenu extends StatelessWidget {
  const MyDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(AppLocalizations.of(context)!.drawerMenuHome),
              onTap: () {
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
          ],
        ),
      ),
    );
  }
}
