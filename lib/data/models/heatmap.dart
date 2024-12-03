import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/data/models/habit.dart';

class HeatMap {
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

  static Map<DateTime, int> generateHeatMapForHabit(Habit habit) {
    final Map<DateTime, int> heatMapData = {};

    habit.progress.forEach((date, status) {
      heatMapData[date] = (status == ProgressStatus.completed) ? 100 : 0;
    });

    return heatMapData;
  }
}
