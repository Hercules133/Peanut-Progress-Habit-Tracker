import 'package:get_it/get_it.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/repositories/id_repository.dart';
import 'package:peanutprogress/services/storage/shared_preferences_storage.dart';
import 'package:peanutprogress/services/storage/storage_service.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/habit_repository.dart';

/// A singleton instance of the [GetIt] service locator that provides access to
/// various dependencies across the application.
final locator = GetIt.instance;

/// Configures the service locator by registering various services
/// and providers.
///
/// This function registers:
/// - [StorageService] as [SharedPreferencesStorage] for data storage.
/// - [HabitRepository] as a singleton for managing habit-related data.
/// - [IdRepository] as a singleton for managing ID-related data.
/// - [HabitProvider] as a factory, using [HabitRepository] for business logic.
/// - [CategoryProvider] as a singleton for managing categories.
void setupLocator() {
  locator.registerSingleton<StorageService>(SharedPreferencesStorage());
  locator.registerSingleton<HabitRepository>(HabitRepository());
  locator.registerSingleton<IdRepository>(IdRepository());
  locator.registerFactory<HabitProvider>(
      () => HabitProvider(locator<HabitRepository>()));
  locator.registerSingleton<CategoryProvider>(CategoryProvider());
}
