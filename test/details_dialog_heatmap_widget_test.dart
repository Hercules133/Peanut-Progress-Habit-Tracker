import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/widgets/details_dialog_heatmap_widget.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/data/models/theme.dart';
import 'package:peanutprogress/data/models/heatmap.dart' as hm;
import 'package:peanutprogress/core/utils/enums/progress_status.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  testWidgets('Heatmap displays correctly', (WidgetTester tester) async {
    final Habit mockHabit = Habit(
      id: 1,
      title: 'mockHabit',
      description: 'Habit for testing',
      days: [DayOfWeek.friday],
      progress: {
        DateTime(2024, 12, 12): ProgressStatus.completed,
        DateTime(2024, 12, 13): ProgressStatus.notCompleted
      },
      category: Category.defaultCategory(),
      time: const TimeOfDay(hour: 12, minute: 12),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        home: Scaffold(
          body: MyHeatMap(habit: mockHabit),
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

  testWidgets('HeatMap colors are correct', (WidgetTester tester) async {
    final Habit mockHabit = Habit(
      id: 1,
      title: 'mockHabit',
      description: 'Habit for testing',
      days: [DayOfWeek.friday],
      progress: {
        DateTime(2024, 12, 12): ProgressStatus.completed,
        DateTime(2024, 12, 13): ProgressStatus.notCompleted
      },
      category: Category.defaultCategory(),
      time: const TimeOfDay(hour: 12, minute: 12),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        home: Scaffold(
          body: MyHeatMap(habit: mockHabit),
        ),
      ),
    );
    final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
    final ownColors = Theme.of(tester.element(find.byType(MyHeatMap)))
        .extension<OwnColors>()!;
    expect(heatMap.defaultColor, equals(ownColors.contributionDefault));
    expect(heatMap.colorsets[0], equals(ownColors.contribution0));
    expect(heatMap.colorsets[1], equals(ownColors.contribution5));
    expect(heatMap.colorTipCount, equals(2));
    expect(heatMap.colorMode, equals(ColorMode.color));
    expect(heatMap.colorTipHelper?.length, equals(2));
  });

  testWidgets('Heatmap is scrollable', (WidgetTester tester) async {
    final Habit mockHabit = Habit(
      id: 1,
      title: 'mockHabit',
      description: 'Habit for testing',
      days: [DayOfWeek.friday],
      progress: {
        DateTime(2024, 12, 12): ProgressStatus.completed,
        DateTime(2024, 12, 13): ProgressStatus.notCompleted
      },
      category: Category.defaultCategory(),
      time: const TimeOfDay(hour: 12, minute: 12),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        home: Scaffold(
          body: MyHeatMap(habit: mockHabit),
        ),
      ),
    );

    final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
    expect(heatMap.scrollable, true);
  });

  testWidgets('Heatap dataset is correct', (WidgetTester tester) async {
    final Habit mockHabit = Habit(
      id: 1,
      title: 'mockHabit',
      description: 'Habit for testing',
      days: [DayOfWeek.friday],
      progress: {
        DateTime(2024, 12, 12): ProgressStatus.completed,
        DateTime(2024, 12, 13): ProgressStatus.notCompleted
      },
      category: Category.defaultCategory(),
      time: const TimeOfDay(hour: 12, minute: 12),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        home: Scaffold(
          body: MyHeatMap(habit: mockHabit),
        ),
      ),
    );

    final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
    final dataset = hm.HeatMap.generateHeatMapForHabit(mockHabit);
    expect(heatMap.datasets, equals(dataset));
    expect(heatMap.datasets?.length, 2);
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

    await tester.pumpWidget(
      MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        home: Scaffold(
          body: MyHeatMap(habit: mockHabit),
        ),
      ),
    );

    final heatMap = tester.firstWidget(find.byType(HeatMap)) as HeatMap;
    expect(heatMap.datasets?.isEmpty, true);
  });
}
