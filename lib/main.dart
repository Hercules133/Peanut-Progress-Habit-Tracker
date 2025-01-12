import 'package:flutter/material.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:peanutprogress/data/providers/username_provider.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/features/create_habit/view/create_habit_screen.dart';
import 'package:peanutprogress/features/home_page/view/home_page_screen.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/features/settings_page/view/settings_page.dart';
import 'package:peanutprogress/features/statistics_page/view/statistics_screen.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/features/settings_page/view/switch_state.dart';
import 'package:peanutprogress/features/home_page/view/habits.dart';
import 'package:peanutprogress/core/config/notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:peanutprogress/features/home_page/view/walkthrough_screen.dart';
import 'package:peanutprogress/features/home_page/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await NotificationService.init();
  tz.initializeTimeZones();
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
        ChangeNotifierProvider(
          create: (context) => UsernameProvider()..fetchUsername(),
        ),
      ],
      child: Consumer2<SwitchState, LocaleProvider>(
        builder: (context, switchState, localeProvider, _) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: switchState.themeMode,
            home: const MySplashScreen(),
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
              Routes.walkthrough: (context) => const MyWalkthroughPage(),
            },
          );
        },
      ),
    );
  }
}
