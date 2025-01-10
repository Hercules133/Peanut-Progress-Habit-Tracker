import 'package:mocktail/mocktail.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/models/heatmap.dart' as hm;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockHabitProvider extends Mock implements HabitProvider {}

void main() {
  setUpAll(
    () {
      SharedPreferences.setMockInitialValues({});
      setupLocator();
      TestWidgetsFlutterBinding.ensureInitialized();
    },
  );

  group('test generateHeatmapData function', () {
    test(
      'generateHeatmapData calculates the correct data for multiple habits',
      () async {
        Habit mockHabit1 = Habit(
          time: TimeOfDay(hour: 12, minute: 12),
          id: 1,
          description: 'This is Habit for testing',
          days: [DayOfWeek.friday, DayOfWeek.monday],
          category: Category.defaultCategory(),
          title: 'Test Habit',
          progress: {
            DateTime(2024, 12, 13): ProgressStatus.completed,
            DateTime(2021, 12, 9): ProgressStatus.notCompleted,
          },
        );
        Habit mockHabit2 = Habit(
          time: TimeOfDay(hour: 12, minute: 12),
          id: 2,
          description: 'This is also a Habit for testing',
          days: [DayOfWeek.friday, DayOfWeek.sunday],
          category: Category.defaultCategory(),
          title: 'Test Habit',
          progress: {
            DateTime(2024, 12, 13): ProgressStatus.notCompleted,
            DateTime(2024, 12, 15): ProgressStatus.completed,
          },
        );
        HabitProvider habitProvider = locator<HabitProvider>();
        await habitProvider.addHabit(mockHabit1);
        await habitProvider.addHabit(mockHabit2);

        final heatmapData = hm.HeatMap.generateHeatMapData(habitProvider);
        expect(heatmapData[DateTime(2024, 12, 13)], 50);
        expect(heatmapData[DateTime(2021, 12, 9)], 0);
        expect(heatmapData[DateTime(2024, 12, 15)], 100);
      },
    );

    test(
      'generateHeatmapData calculates the correct data for one habit',
      () async {
        Habit mockHabit1 = Habit(
          time: TimeOfDay(hour: 12, minute: 12),
          id: 3,
          description: 'This is Habit for testing',
          days: [DayOfWeek.friday, DayOfWeek.monday],
          category: Category.defaultCategory(),
          title: 'Test Habit',
          progress: {
            DateTime(2024, 12, 13): ProgressStatus.completed,
            DateTime(2021, 12, 9): ProgressStatus.notCompleted,
          },
        );

        HabitProvider habitProvider = locator<HabitProvider>();
        habitProvider.clearAllHabits();
        await habitProvider.addHabit(mockHabit1);

        final heatmapData = hm.HeatMap.generateHeatMapData(habitProvider);
        expect(heatmapData[DateTime(2024, 12, 13)], 100);
        expect(heatmapData[DateTime(2021, 12, 9)], 0);
      },
    );

    test('generateHeatmapData handles habit without progress', () async {
      Habit mockHabit1 = Habit(
        time: TimeOfDay(hour: 12, minute: 12),
        id: 4,
        description: 'This is Habit for testing',
        days: [DayOfWeek.friday, DayOfWeek.monday],
        category: Category.defaultCategory(),
        title: 'Test Habit',
        progress: {},
      );
      HabitProvider habitProvider = locator<HabitProvider>();
      habitProvider.clearAllHabits();
      await habitProvider.addHabit(mockHabit1);

      final heatmapData = hm.HeatMap.generateHeatMapData(habitProvider);
      expect(heatmapData.isEmpty, true);
    });
    test('generateHeatmapData returns empty map for empty HabitProvider', () {
      HabitProvider habitProvider = locator<HabitProvider>();
      habitProvider.clearAllHabits();
      final heatmapData = hm.HeatMap.generateHeatMapData(habitProvider);
      expect(heatmapData.isEmpty, true);
    });
  });

  group('test generateHeatmapForHabit function', () {
    test('generateHeatmapForHabit is correct', () {
      Habit mockHabit1 = Habit(
        time: TimeOfDay(hour: 12, minute: 12),
        id: 1,
        description: 'This is Habit for testing',
        days: [DayOfWeek.friday, DayOfWeek.monday],
        category: Category.defaultCategory(),
        title: 'Test Habit',
        progress: {
          DateTime(2024, 12, 13): ProgressStatus.completed,
          DateTime(2021, 12, 9): ProgressStatus.notCompleted,
        },
      );
      final heatmapData = hm.HeatMap.generateHeatMapForHabit(mockHabit1);
      expect(heatmapData[DateTime(2024, 12, 13)], 100);
      expect(heatmapData[DateTime(2021, 12, 9)], 0);
    });

    test('generateHeatmapForHabit returns empty map for empty habit', () {
      Habit mockHabit1 = Habit(
        time: TimeOfDay(hour: 12, minute: 12),
        id: 1,
        description: 'This is Habit for testing',
        days: [DayOfWeek.friday, DayOfWeek.monday],
        category: Category.defaultCategory(),
        title: 'Test Habit',
        progress: {},
      );
      final heatmapData = hm.HeatMap.generateHeatMapForHabit(mockHabit1);
      expect(heatmapData.isEmpty, true);
    });
  });
}
