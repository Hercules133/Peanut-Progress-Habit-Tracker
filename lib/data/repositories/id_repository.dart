import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/services/storage/storage_service.dart';

/// A repository class responsible for generating and managing unique habit IDs.
/// It interacts with the storage layer to persist and retrieve the current
/// habit ID counter.
class IdRepository {
  final StorageService _storageService = locator<StorageService>();

  static const String _habitIdTable = 'habit_id_table';
  static const String _habitIdCounterKey = 'habit_id_counter';

  /// Retrieves the current habit ID from the storage.
  /// If no ID is found, it defaults to 0.
  ///
  /// Returns the current habit ID as an [int].
  Future<int> getCurrentHabitId() async {
    Map<String, dynamic>? habitIdMap =
        await _storageService.read(_habitIdTable, _habitIdCounterKey);

    return habitIdMap?[_habitIdCounterKey] ?? 0;
  }

  /// Generates the next habit ID by incrementing the current habit ID.
  /// The new ID is saved to the storage.
  ///
  /// Returns the newly generated habit ID as an [int].
  Future<int> generateNextHabitId() async {
    int currentId = await getCurrentHabitId();
    int newId = currentId + 1;

    await _storageService.save(
      _habitIdTable,
      {_habitIdCounterKey: newId},
      (data) => _habitIdCounterKey,
    );

    return newId;
  }
}
