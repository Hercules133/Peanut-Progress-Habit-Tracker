import '/services/storage/storage_service.dart';
import '/core/config/locator.dart';
import '/data/models/habit.dart';

/// A repository class responsible for interacting with the storage layer
/// to persist and retrieve habit data.
class HabitRepository {
  final StorageService _storageService = locator<StorageService>();

  /// Saves a habit to the storage.
  ///
  /// [habit] - The habit to save.
  /// The habit will be converted to a map using [habit.toMap()] and saved under
  /// the 'habits' key.
  Future<void> saveHabit(Habit habit) async {
    await _storageService.save(
        'habits', habit.toMap(), (data) => data['id'].toString());
  }

  /// Fetches all habits from the storage and returns them as a list of [Habit]
  /// objects.
  ///
  /// Returns a [List<Habit>] of all habits retrieved from the storage.
  Future<List<Habit>> getAllHabits() async {
    final habitMaps = await _storageService.readAll('habits');
    return habitMaps.map((map) => Habit.fromMap(map)).toList();
  }

  /// Deletes a habit from the storage by its ID.
  ///
  /// [habitId] - The ID of the habit to delete.
  Future<void> deleteHabit(int habitId) async {
    await _storageService.delete('habits', habitId.toString());
  }

  /// Clears all habits from the storage.
  Future<void> clearAllHabits() async {
    await _storageService.clear('habits');
  }
}
