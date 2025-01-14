import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/color_ex.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/core/utils/get_greeting.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:peanutprogress/features/create_habit/view/create_habit_screen.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:peanutprogress/features/home_page/view/home_page_screen.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_view_widget.dart';
import 'package:peanutprogress/features/home_page/view/tab_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
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
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
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
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(),
          ),
        ],
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: lightMode,
          darkTheme: darkMode,
          home: MyHomePage(),
        ),
      ),
    );

    final greeting = getGreeting();
    expect(find.text(greeting), findsOne);
  });

  group('test TabBar', () {
    testWidgets('Tab All is visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: locator<CategoryProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
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
    testWidgets('finds Tab for new category', (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();
      Category mockCategory =
          Category(name: 'mockCategory', color: Colors.pink, icon: Icons.star);
      categoryProvider.addCategory(mockCategory);
      var mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'This is a habit for testing.',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory);
      await habitProvider.addHabit(mockHabit1);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: categoryProvider,
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text(mockCategory.name), findsOne);
      expect(find.byIcon(mockCategory.icon), findsOne);
      expect(find.text('All'), findsOne);
      expect(find.byIcon(Icons.list_alt), findsOne);
      expect(find.byType(Tab), findsExactly(2));
    });

    testWidgets('Only Categorys with pending Habits are shown',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();
      var mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'This is a habit for testing.',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {dateOnly(DateTime.now()): ProgressStatus.completed},
          category: Category(
              name: 'mockCategory', color: Colors.pink, icon: Icons.star));

      await habitProvider.addHabit(mockHabit1);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: categoryProvider,
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );

      expect(find.text('All'), findsOne);
      expect(find.byIcon(Icons.list_alt), findsOne);
      expect(find.byType(Tab), findsExactly(1));
    });

    testWidgets('Active Tab is marked', (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();
      var mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'This is a habit for testing.',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: Category(
              name: 'mockCategory', color: Colors.pink, icon: Icons.star));
      await habitProvider.addHabit(mockHabit1);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: categoryProvider,
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );

      expect(find.byType(Tab), findsExactly(2));

      expect(categoryProvider.selectedIndex, 0);
      await tester.tap(find.text('mockCategory'));
      await tester.pumpAndSettle();

      expect(categoryProvider.selectedIndex, 1);
    });
  });

  group('test TabBarView', () {
    testWidgets('no Habits displayed if HabitProvider is empty',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      habitProvider.clearAllHabits();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: locator<CategoryProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );
      expect(find.byType(Tab), findsOne);
      expect(find.text('No habits available.'), findsOne);
    });

    testWidgets('All Tab shows all pending Habits correctly',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();

      Category mockCategory1 = Category(
          name: 'mockCategory1', color: Colors.pink, icon: Icons.mouse);
      Category mockCategory2 = Category(
          name: 'mockCategory2', color: Colors.blue, icon: Icons.house);

      categoryProvider.addCategory(mockCategory1);
      categoryProvider.addCategory(mockCategory2);

      Habit mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'this is a Habit for testing',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory1);
      Habit mockHabit2 = Habit(
          id: 1,
          title: 'mockHabit2',
          description: 'this is also a Habit for testing',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory2);

      habitProvider.addHabit(mockHabit1);
      habitProvider.addHabit(mockHabit2);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: locator<CategoryProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );

      expect(find.byType(Card), findsExactly(2));
      expect(find.text(mockHabit1.title), findsOne);
      expect(find.text(mockHabit2.title), findsOne);

      expect((tester.widget(find.byType(Card).at(0)) as Card).color!.toARGB32,
          mockHabit1.category.color.toARGB32);
      expect((tester.widget(find.byType(Card).at(1)) as Card).color!.toARGB32,
          mockHabit2.category.color.toARGB32);
    });

    testWidgets('Category Tab shows only pending Hbaits of Category',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();

      Category mockCategory1 = Category(
          name: 'mockCategory1', color: Colors.pink, icon: Icons.mouse);
      Category mockCategory2 = Category(
          name: 'mockCategory2', color: Colors.blue, icon: Icons.house);

      categoryProvider.addCategory(mockCategory1);
      categoryProvider.addCategory(mockCategory2);

      Habit mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'this is a Habit for testing',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory1);
      Habit mockHabit2 = Habit(
          id: 1,
          title: 'mockHabit2',
          description: 'this is also a Habit for testing',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory2);

      habitProvider.addHabit(mockHabit1);
      habitProvider.addHabit(mockHabit2);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: locator<CategoryProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );

      await tester.tap(find.text('mockCategory1'));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsExactly(1));
      expect(find.text(mockHabit1.title), findsOne);
      expect((tester.widget(find.byType(Card).at(0)) as Card).color!.toARGB32,
          mockHabit1.category.color.toARGB32);
    });

    testWidgets('mark Habit as Completed is working',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      CategoryProvider categoryProvider = locator<CategoryProvider>();
      habitProvider.clearAllHabits();

      Category mockCategory1 = Category(
          name: 'mockCategory1', color: Colors.pink, icon: Icons.mouse);
      categoryProvider.addCategory(mockCategory1);

      Habit mockHabit1 = Habit(
          id: 0,
          title: 'mockHabit1',
          description: 'this is a Habit for testing',
          days: [DayOfWeek.values[DateTime.now().weekday - 1]],
          time: TimeOfDay(hour: 12, minute: 12),
          progress: {},
          category: mockCategory1);

      habitProvider.addHabit(mockHabit1);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>.value(
              value: habitProvider,
            ),
            ChangeNotifierProvider<CategoryProvider>.value(
              value: locator<CategoryProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            theme: lightMode,
            darkTheme: darkMode,
            home: MyHomePage(),
          ),
        ),
      );
      final toggleButton = find.widgetWithImage(
          IconButton, const AssetImage('assets/images/Erdnuss.png'));

      expect(find.byType(Card), findsOne);
      await tester.tap(toggleButton);
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsNothing);
    });
  });
}
