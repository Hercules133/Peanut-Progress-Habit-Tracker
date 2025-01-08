import 'package:get_it/get_it.dart';
import 'package:peanutprogress/features/create_habit/view/inherited_widget_create_habit.dart';
import '/data/providers/category_provider.dart';
import '/data/repositories/id_repository.dart';
import '/services/storage/shared_preferences_storage.dart';
import '/services/storage/storage_service.dart';
import '/data/providers/habit_provider.dart';
import '/data/repositories/habit_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<StorageService>(SharedPreferencesStorage());
  locator.registerSingleton<HabitRepository>(HabitRepository());
  locator.registerSingleton<IdRepository>(IdRepository());
  locator.registerFactory<HabitProvider>(
      () => HabitProvider(locator<HabitRepository>()));
  locator.registerSingleton<CategoryProvider>(CategoryProvider());
  locator.registerSingleton<ProviderCreateHabit>(ProviderCreateHabit());
}
