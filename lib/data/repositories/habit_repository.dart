import 'package:streaks/services/storage/storage_service.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/data/models/habit.dart';

class HabitRepository {
  final StorageService _storageService = locator<StorageService>();

  Future<void> saveHabit(Habit habit) async {
    await _storageService.save(
        'habits', habit.toMap(), (data) => data['id'].toString());
  }

  Future<List<Habit>> getAllHabits() async {
    final habitMaps = await _storageService.readAll('habits');
    return habitMaps.map((map) => Habit.fromMap(map)).toList();
  }

  Future<void> deleteHabit(int habitId) async {
    await _storageService.delete('habits', habitId.toString());
  }

  Future<void> clearAllHabits() async {
    await _storageService.clear('habits');
  }
}
