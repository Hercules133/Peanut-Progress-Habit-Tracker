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
}
