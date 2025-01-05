import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/features/create_habit/view/create_habit_screen.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:peanutprogress/features/home_page/view/home_page_screen.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_view_widget.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });
  testWidgets('Homepage displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HabitProvider>(
            create: (context) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
        ],
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          routes: {},
          home: MyHomePage(),
        ),
      ),
    );

    expect(find.byType(MyAppBar), findsOneWidget);
    expect(find.byType(MyHeatMap), findsOneWidget);
    expect(find.byType(MyTabBar), findsOneWidget);
    expect(find.byType(MyTabBarView), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Add Button is working', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HabitProvider>(
            create: (context) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
        ],
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          routes: {
            Routes.add: (context) => const CreateHabit(newHabit: true),
          },
          home: MyHomePage(),
        ),
      ),
    );
    final addButton = find.byType(FloatingActionButton);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.byType(CreateHabit), findsOne);
  });

  testWidgets('Tab with all Habits is visible', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HabitProvider>(
            create: (context) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
        ],
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          home: MyHomePage(),
        ),
      ),
    );

    expect(find.byType(Tab), findsOne);
    expect(find.text(Category.defaultCategory().name), findsOne);
    expect(find.byIcon(Category.defaultCategory().icon), findsOne);
    expect(find.text('No habits available.'), findsOne);
  });

  testWidgets('AppBar shows correct Greeting based on time',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<HabitProvider>(
            create: (context) => locator<HabitProvider>(),
          ),
          ChangeNotifierProvider<CategoryProvider>.value(
            value: locator<CategoryProvider>(),
          ),
        ],
        child: MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          home: MyHomePage(),
        ),
      ),
    );

    final greeting = getGreeting();
    expect(find.text(greeting), findsOne);
  });
}
