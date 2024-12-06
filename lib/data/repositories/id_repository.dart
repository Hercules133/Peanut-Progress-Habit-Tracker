import 'package:streaks/core/config/locator.dart';
import 'package:streaks/services/storage/storage_service.dart';

class IdRepository {
  final StorageService _storageService = locator<StorageService>();

  static const String _habitIdTable = 'habit_id_table';
  static const String _habitIdCounterKey = 'habit_id_counter';

  Future<int> getCurrentHabitId() async {
    Map<String, dynamic>? habitIdMap =
        await _storageService.read(_habitIdTable, _habitIdCounterKey);

    return habitIdMap?[_habitIdCounterKey] ?? 0;
  }

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
