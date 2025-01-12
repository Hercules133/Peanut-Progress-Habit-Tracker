import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/features/home_page/view/heat_map_widget.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/models/heatmap.dart' as hm;
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitProvider extends Mock implements HabitProvider {}

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });
  group('Heatmap Widget Rendering Tests', () {
    testWidgets('Heatmap displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            routes: {},
            home: Scaffold(
              body: MyHeatMap(),
            ),
          ),
        ),
      );

      expect(find.byType(MyHeatMap), findsOne);
      expect(find.byType(HeatMap), findsOne);

      final container = tester.firstWidget(find.byType(Container)) as Container;
      expect(container.decoration, isA<BoxDecoration>());

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(10));
      expect(decoration.color, isNotNull);
      expect(decoration.color, equals(lightMode.colorScheme.primary));
    });
    testWidgets('HeatMap is scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            routes: {},
            home: Scaffold(
              body: MyHeatMap(),
            ),
          ),
        ),
      );

      final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
      expect(heatMap.scrollable, true);
    });
  });

  group('Heatmap Functional Tests', () {
    testWidgets('HeatMap colors are correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (context) => locator<HabitProvider>(),
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            routes: {},
            home: Scaffold(
              body: MyHeatMap(),
            ),
          ),
        ),
      );

      final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
      final ownColors = Theme.of(tester.element(find.byType(MyHeatMap)))
          .extension<OwnColors>()!;
      expect(heatMap.defaultColor, equals(ownColors.contributionDefault));
      expect(heatMap.colorsets[0], equals(ownColors.contribution0));
      expect(heatMap.colorsets[1], equals(ownColors.contribution1));
      expect(heatMap.colorsets[25], equals(ownColors.contribution2));
      expect(heatMap.colorsets[50], equals(ownColors.contribution3));
      expect(heatMap.colorsets[75], equals(ownColors.contribution4));
      expect(heatMap.colorsets[100], equals(ownColors.contribution5));

      expect(heatMap.colorTipCount, equals(5));
      expect(heatMap.colorMode, equals(ColorMode.color));
      expect(heatMap.colorTipHelper?.length, equals(2));
    });

    testWidgets('HeatMap dataset is correct', (WidgetTester tester) async {
      final Habit mockHabit = Habit(
        id: 1,
        title: 'mockHabit',
        description: 'Habit for testing',
        days: [DayOfWeek.friday],
        progress: {
          DateTime(2024, 12, 13): ProgressStatus.completed,
          DateTime(2024, 12, 20): ProgressStatus.notCompleted,
          DateTime(2024, 12, 27): ProgressStatus.completed,
        },
        category: Category.defaultCategory(),
        time: const TimeOfDay(hour: 12, minute: 12),
      );
      final Habit mockHabit2 = Habit(
        id: 2,
        title: 'mockHabit2',
        description: 'second Habit for testing',
        days: [DayOfWeek.friday],
        progress: {
          DateTime(2024, 12, 13): ProgressStatus.notCompleted,
          DateTime(2024, 12, 20): ProgressStatus.notCompleted
        },
        category: Category.defaultCategory(),
        time: const TimeOfDay(hour: 12, minute: 12),
      );

      HabitProvider habitProvider = locator<HabitProvider>();
      await habitProvider.addHabit(mockHabit);
      await habitProvider.addHabit(mockHabit2);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => habitProvider,
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            routes: {},
            home: Scaffold(
              body: MyHeatMap(),
            ),
          ),
        ),
      );

      final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
      final dataset = hm.HeatMap.generateHeatMapData(habitProvider);
      expect(heatMap.datasets, equals(dataset));
      expect(heatMap.datasets?.length, 3);
      expect(heatMap.datasets?[DateTime(2024, 12, 13)], equals(50));
      expect(heatMap.datasets?[DateTime(2024, 12, 20)], equals(0));
      expect(heatMap.datasets?[DateTime(2024, 12, 27)], equals(100));
    });

    testWidgets('HeatMap with empty dataset', (WidgetTester tester) async {
      final Habit mockHabit = Habit(
        id: 1,
        title: 'mockHabit',
        description: 'Habit for testing',
        days: [DayOfWeek.friday],
        progress: {},
        category: Category.defaultCategory(),
        time: const TimeOfDay(hour: 12, minute: 12),
      );

      HabitProvider habitProvider = locator<HabitProvider>();
      await habitProvider.clearAllHabits();
      await habitProvider.addHabit(mockHabit);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<HabitProvider>(
              create: (_) => habitProvider,
            ),
          ],
          child: MaterialApp(
            theme: lightMode,
            darkTheme: darkMode,
            routes: {},
            home: Scaffold(
              body: MyHeatMap(),
            ),
          ),
        ),
      );

      final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
      expect(heatMap.datasets?.isEmpty, true);
    });
  });
}
