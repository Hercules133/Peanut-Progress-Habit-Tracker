import 'package:streaks/services/storage/storage_service.dart';
import 'package:streaks/core/config/locator.dart';

// TODO: After creating the Habit model, update the type of the habitData
// parameter to be Habit and use the fromMap method to convert the data to a
// Habit instance and vice versa.

class HabitRepository {
  final StorageService _storageService = locator<StorageService>();

  Future<void> saveHabit(Map<String, dynamic> habitData) async {
    await _storageService.save('habits', habitData);
  }

  Future<List<Map<String, dynamic>>> getAllHabits() async {
    return await _storageService.readAll('habits');
  }

  Future<void> deleteHabit(String habitId) async {
    await _storageService.delete('habits', habitId);
  }

  Future<void> clearAllHabits() async {
    await _storageService.clear('habits');
  }
}
