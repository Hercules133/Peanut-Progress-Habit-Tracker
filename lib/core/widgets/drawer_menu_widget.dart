import 'package:flutter/material.dart';
import 'package:streaks/core/utils/routes.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';

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
              title: const Text('Home'),
              onTap: () {
                habitProvider.isSearching=false;
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
            ListTile(
              leading: const ImageIcon(
                AssetImage('assets/images/Erdnuss.png'),
              ),
              title: const Text('Habits'),
              onTap: () {
                habitProvider.isSearching=false;
                Navigator.pushReplacementNamed(context, Routes.habits);
              },
            ),
            ListTile(
              leading: const Icon(Icons.signal_cellular_alt),
              title: const Text('Statistics'),
              onTap: () {
                habitProvider.isSearching=false;
                Navigator.pushReplacementNamed(context, Routes.statistics);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                habitProvider.isSearching=false;
                Navigator.pushReplacementNamed(context, Routes.settings);
              },
            ),
          ],
        ),
      ),
    );
  }
}
