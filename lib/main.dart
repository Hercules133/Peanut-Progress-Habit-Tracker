import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/data/models/theme.dart';
import 'package:streaks/features/create_habit/view/create_habit_screen.dart';
import 'package:streaks/features/home_page/view/home_page_screen.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/settings_page/view/settings_page.dart';
import 'package:streaks/features/statistics_page/view/statistics_screen.dart';
import 'core/utils/routes.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HabitProvider>(
          create: (_) => locator<HabitProvider>()..fetchHabits(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.home: (context) => const MyHomePage(),
          Routes.addAndEdit: (context) => const CreateHabit(),
          // Routes.habits: (context) => const
          Routes.settings: (context) => const SettingsPage(),
          Routes.statistics: (context) => const StatisticsPage(),
        },
      ),
    );
  }
}