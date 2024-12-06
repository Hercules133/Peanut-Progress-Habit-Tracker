import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/models/theme.dart';
import 'package:streaks/features/create_habit/view/create_habit_screen.dart';
import 'package:streaks/features/home_page/view/home_page_screen.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/settings_page/view/settings_page.dart';
import 'package:streaks/features/statistics_page/view/statistics_screen.dart';
import 'core/utils/routes.dart';
import 'package:streaks/data/models/habit.dart';
import 'features/settings_page/view/switch_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  try {
    final habitProvider = locator<HabitProvider>();
    await habitProvider.fetchHabits();

    final categoryProvider = locator<CategoryProvider>();
    categoryProvider.initilizeCategories(habitProvider.habits);
  } catch (e) {
    debugPrint("Error during initialization: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HabitProvider>(
          create: (_) => locator<HabitProvider>(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => locator<CategoryProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => SwitchState(),
        ),
      ],
      child: Consumer<SwitchState>(
        builder: (context, switchState, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:
                switchState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
            routes: {
              Routes.home: (context) => const MyHomePage(),
              Routes.addAndEdit: (context) {
                final habit =
                    ModalRoute.of(context)?.settings.arguments as Habit?;
                return CreateHabit(habit: habit);
              },
              Routes.settings: (context) => const SettingsPage(),
              Routes.statistics: (context) => const StatisticsPage(),
            },
          );
        },
      ),
    );
  }
}
