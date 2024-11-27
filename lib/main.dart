import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/features/create_habit/view/create_habit_screen.dart';
import 'package:streaks/features/home_page/view/home_page_screen.dart';
import 'package:streaks/data/providers/habit_provider.dart';
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        routes: {
          Routes.home: (context) => const MyHomePage(),
          // Routes.addAndEdit: (context) => const
          // Routes.habits: (context) => const
          // Routes.settings: (context) => const SettingsScreen(),
          // Routes.statistics: (context) => const
        },
      ),
    );
  }
}