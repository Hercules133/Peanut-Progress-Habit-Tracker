import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/core/widgets/drawer_menu_widget.dart';
import 'package:streaks/data/models/theme.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/home_page/view/habits.dart';
import 'package:streaks/features/home_page/view/home_page_screen.dart';
import 'package:streaks/core/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaks/features/settings_page/view/settings_page.dart';
import 'package:streaks/features/settings_page/view/switch_state.dart';
import 'package:streaks/features/statistics_page/view/statistics_screen.dart';

void main() {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  group(
    'Drawer Tests',
    () {
      testWidgets(
        'Drawer has ListTiles',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
              child: MaterialApp(
                home: Scaffold(
                  key: scaffoldKey,
                  drawer: const MyDrawerMenu(),
                ),
              ),
            ),
          );
          scaffoldKey.currentState!.openDrawer();

          await tester.pumpAndSettle();
          expect(find.byType(ListTile), findsWidgets);
        },
      );

      testWidgets(
        'Drawer has all icons and texts',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
              child: MaterialApp(
                home: Scaffold(
                  key: scaffoldKey,
                  drawer: const MyDrawerMenu(),
                ),
              ),
            ),
          );
          scaffoldKey.currentState!.openDrawer();
          await tester.pumpAndSettle();

          expect(find.text('Home'), findsOneWidget);
          expect(find.text('Habits'), findsOneWidget);
          expect(find.text('Statistics'), findsOneWidget);
          expect(find.text('Settings'), findsOneWidget);

          expect(find.byIcon(Icons.home), findsOneWidget);
          expect(find.byType(Image), findsOneWidget);
          expect(find.byIcon(Icons.signal_cellular_alt), findsOneWidget);
          expect(find.byIcon(Icons.settings), findsOneWidget);
        },
      );
    },
  );
  group(
    'Drawer Navigation Tests',
    () {
      testWidgets('Drawer navigation to SettingsPage',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<HabitProvider>(
                create: (context) => locator<HabitProvider>(),
              ),
              ChangeNotifierProvider<SwitchState>(
                create: (context) => SwitchState(),
              ),
            ],
            child: MaterialApp(
              routes: {
                Routes.home: (context) => const MyHomePage(),
                Routes.settings: (context) => const SettingsPage(),
              },
              home: Scaffold(
                key: scaffoldKey,
                drawer: const MyDrawerMenu(),
              ),
            ),
          ),
        );

        scaffoldKey.currentState?.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();
        expect(find.byType(SettingsPage), findsOneWidget);
      });

      testWidgets('Drawer navigation to Statistics',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<HabitProvider>(
                create: (context) => locator<HabitProvider>(),
              ),
              ChangeNotifierProvider<SwitchState>(
                create: (context) => SwitchState(),
              ),
              ChangeNotifierProvider<CategoryProvider>.value(
                value: locator<CategoryProvider>(),
              ),
            ],
            child: MaterialApp(
              theme: lightMode,
              darkTheme: darkMode,
              routes: {
                Routes.statistics: (context) => const StatisticsPage(),
              },
              home: Scaffold(
                key: scaffoldKey,
                drawer: const MyDrawerMenu(),
              ),
            ),
          ),
        );

        scaffoldKey.currentState?.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Statistics'));
        await tester.pumpAndSettle();
        expect(find.byType(StatisticsPage), findsOneWidget);
      });

      testWidgets('Drawer navigation to Habits', (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<HabitProvider>(
                create: (context) => locator<HabitProvider>(),
              ),
              ChangeNotifierProvider<SwitchState>(
                create: (context) => SwitchState(),
              ),
              ChangeNotifierProvider<CategoryProvider>.value(
                value: locator<CategoryProvider>(),
              ),
            ],
            child: MaterialApp(
              theme: lightMode,
              darkTheme: darkMode,
              routes: {
                Routes.habits: (context) => const MyHabitsPage(),
              },
              home: Scaffold(
                key: scaffoldKey,
                drawer: const MyDrawerMenu(),
              ),
            ),
          ),
        );

        scaffoldKey.currentState?.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Habits'));
        await tester.pumpAndSettle();
        expect(find.byType(MyHabitsPage), findsOneWidget);
      });

      testWidgets(
        'Drawer navigation to Homepage',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<HabitProvider>(
                  create: (context) => locator<HabitProvider>(),
                ),
                ChangeNotifierProvider<SwitchState>(
                  create: (context) => SwitchState(),
                ),
                ChangeNotifierProvider<CategoryProvider>.value(
                  value: locator<CategoryProvider>(),
                ),
              ],
              child: MaterialApp(
                theme: lightMode,
                darkTheme: darkMode,
                routes: {
                  Routes.home: (context) => const MyHomePage(),
                },
                home: Scaffold(
                  key: scaffoldKey,
                  drawer: const MyDrawerMenu(),
                ),
              ),
            ),
          );

          scaffoldKey.currentState?.openDrawer();
          await tester.pumpAndSettle();

          await tester.tap(find.text('Home'));
          await tester.pumpAndSettle();

          expect(find.byType(MyHomePage), findsOneWidget);
        },
      );
    },
  );
}
