import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/models/habit.dart';

/// A utility class that generates data for the heat map.
///
/// The heat map is a calendar view that shows the completion rate of habits.
class HeatMap {
  /// Generates data for the heat map based on all habits in the [habitProvider].
  ///
  /// The completion percentage is calculated based on the number of completed habits
  /// out of the total habits for each day.
  ///
  /// Returns a [Map] where the key is a date [DateTime] and the value is
  /// the completion percentage (0-100) on that day.
  static Map<DateTime, int> generateHeatMapData(HabitProvider habitProvider) {
    final allHabits = habitProvider.habits;
    final Map<DateTime, int> heatMapData = {};

    for (final habit in allHabits) {
      for (final entry in habit.progress.entries) {
        final date = entry.key;
        final status = entry.value;

        if (status == ProgressStatus.completed) {
          heatMapData[date] = (heatMapData[date] ?? 0) + 1;
        }
      }
    }

    final daysWithHabits = <DateTime, int>{};
    for (final habit in allHabits) {
      for (final day in habit.progress.keys) {
        daysWithHabits[day] = (daysWithHabits[day] ?? 0) + 1;
      }
    }

    daysWithHabits.forEach((date, totalHabits) {
      final completed = heatMapData[date] ?? 0;
      heatMapData[date] = ((completed / totalHabits) * 100).round();
    });

    return heatMapData;
  }

  /// Generates data for the heat map based on a single habit.
  ///
  /// The value is 100 if the habit was completed on that date, otherwise 0.
  /// Returns a [Map] where the key is a date [DateTime] and the values
  /// is the completion state on that day.

  static Map<DateTime, int> generateHeatMapForHabit(Habit habit) {
    final Map<DateTime, int> heatMapData = {};

    habit.progress.forEach((date, status) {
      heatMapData[date] = (status == ProgressStatus.completed) ? 100 : 0;
    });

    return heatMapData;
  }
}
