
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/ordinal/pie.dart';
import 'package:d_chart/time/line.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/widgets/app_bar_widget.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/providers/locale_provider.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/bar_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/line_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/pie_chart_widget.dart';
import 'package:peanutprogress/features/statistics_page/view/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Statistics Screen is rendering correct', () {
    testWidgets('Statistics screen shows statistics',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(PieChartWidget), findsOneWidget);
      expect(find.byType(MyHeatMap), findsOneWidget);
      expect(find.byType(BarChartWidget), findsOneWidget);
      expect(find.byType(LineChartWidget), findsOneWidget);
    });

    testWidgets('Statistics screen shows AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MyAppBar), findsOneWidget);
      expect(find.text('Statistics'), findsOneWidget);
    });

    testWidgets('Screen adapts to wide layout', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = Size(800, 600);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(ValueKey('SingleChildScrollView 1')), findsOneWidget);
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('Screen adapts to narrow layout', (WidgetTester tester) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = Size(400, 600);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byKey(ValueKey('SingleChildScrollView 2')), findsOneWidget);
      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('BarChart tests', () {
    testWidgets('BarChartWidget is rendering with Chart and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );

      expect(find.text('How many created habits on a day (all categories)'),
          findsOneWidget);
      expect(find.byType(BarChartWidget), findsOneWidget);
      expect(find.byType(DChartBarO), findsOneWidget);
    });

    testWidgets('weekdays are shown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );
      expect(find.text('Mon'), findsOne);
      expect(find.text('Tue'), findsOne);
      expect(find.text('Wed'), findsOne);
      expect(find.text('Thu'), findsOne);
      expect(find.text('Fri'), findsOne);
      expect(find.text('Sat'), findsOne);
      expect(find.text('Sun'), findsOne);
    });
  });

  group('LineChart tests', () {
    testWidgets('LineChartWidget renders with Chart and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );

      expect(
          find.text(
              'Completed habits in the last 10 weeks (all categories, per week)'),
          findsOneWidget);
      expect(find.byType(LineChartWidget), findsOneWidget);
      expect(find.byType(DChartLineT), findsOneWidget);
    });

    testWidgets('weeks are shown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => locator<HabitProvider>(),
            ),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
              theme: lightMode,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: Locale('en'),
              home: Scaffold(
                body: StatisticsPage(),
              )),
        ),
      );
      final lineChartWidget =
          tester.widget<LineChartWidget>(find.byType(LineChartWidget));
      expect(lineChartWidget.series1.length, 10);
    });
  });

  group('PieChart tests', () {
    testWidgets('PieChartWidget renders with title and chart,',
        (WidgetTester tester) async {
      HabitProvider habitProvider = locator<HabitProvider>();
      habitProvider.clearAllHabits();
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(create: (_) => habitProvider),
            ChangeNotifierProvider<LocaleProvider>(
              create: (context) => LocaleProvider(),
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            locale: Locale('en'),
            home: StatisticsPage(),
          ),
        ),
      );
      expect(find.text('Completed today (%/category)'), findsOneWidget);
      expect(find.byType(PieChartWidget), findsOneWidget);
      expect(find.byType(DChartPieO), findsOneWidget);
    });
  });
}
