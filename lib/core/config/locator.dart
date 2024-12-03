import 'package:get_it/get_it.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/repositories/id_repository.dart';
import 'package:streaks/services/storage/shared_preferences_storage.dart';
import 'package:streaks/services/storage/storage_service.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/data/repositories/habit_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<StorageService>(SharedPreferencesStorage());
  locator.registerSingleton<HabitRepository>(HabitRepository());
  locator.registerSingleton<IdRepository>(IdRepository());
  locator.registerFactory<HabitProvider>(
      () => HabitProvider(locator<HabitRepository>()));
  locator.registerSingleton<CategoryProvider>(CategoryProvider());
}
