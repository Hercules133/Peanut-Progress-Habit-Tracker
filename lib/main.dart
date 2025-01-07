import 'package:flutter/material.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import '/core/config/locator.dart';
import 'package:provider/provider.dart';
import '/data/providers/category_provider.dart';
import '/data/models/theme.dart';
import '/features/create_habit/view/create_habit_screen.dart';
import '/features/home_page/view/home_page_screen.dart';
import '/data/providers/habit_provider.dart';
import '/features/settings_page/view/settings_page.dart';
import '/features/statistics_page/view/statistics_screen.dart';
import 'core/utils/routes.dart';
import '/data/models/habit.dart';
import 'features/settings_page/view/switch_state.dart';
import '/features/home_page/view/habits.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => locator<CategoryProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => SwitchState(),
        ),
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider()..fetchLocale(),
        ),
      ],
      child: Consumer2<SwitchState, LocaleProvider>(
        builder: (context, switchState, localeProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: switchState.themeMode,
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeProvider.locale,
            routes: {
              Routes.home: (context) => const MyHomePage(),
              Routes.edit: (context) {
                final habit =
                    ModalRoute.of(context)?.settings.arguments as Habit?;
                return CreateHabit(habit: habit, newHabit: false);
              },
              Routes.add: (context) => const CreateHabit(
                    newHabit: true,
                  ),
              Routes.habits: (context) => const MyHabitsPage(),
              Routes.settings: (context) => const SettingsPage(),
              Routes.statistics: (context) => const StatisticsPage(),
            },
          );
        },
      ),
    );
  }
}
