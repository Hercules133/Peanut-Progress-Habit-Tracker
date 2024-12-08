import 'package:flutter/material.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/repositories/habit_repository.dart';
import 'package:streaks/data/models/habit.dart';

class HabitProvider with ChangeNotifier {
  final HabitRepository _habitRepository;
  final categoryProvider = locator<CategoryProvider>();

  HabitProvider(this._habitRepository);

  List<Habit> _habits = [];
  List<Habit> _filteredHabits = [];
  List<Habit> get habits => _isSearching ? _filteredHabits : _habits;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSearching = false; // Status der Suchleiste
  String _query = ""; // Aktuelle Suchanfrage

  bool get isSearching => _isSearching;

  Future<void> fetchHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _habitRepository.getAllHabits();
      categoryProvider.initilizeCategories(_habits);
    } catch (e) {
      debugPrint('Error fetching habits: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      _query = "";
      _filteredHabits = _habits; // Zeige alle Habits wieder an
    }
    notifyListeners();
  }

  void updateQuery(String query) {
    _query = query;
    _filteredHabits = _habits
        .where((habit) => habit.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    notifyListeners(); // UI über Änderungen informieren
  }

  Future<void> addHabit(Habit habit) async {
    try {
      final isExistingCategory =
          categoryProvider.doesCategoryExist(habit.category);

      if (!isExistingCategory) {
        categoryProvider.addCategory(habit.category);
      }

      await _habitRepository.saveHabit(habit);
      await fetchHabits();
    } catch (e) {
      debugPrint('Error saving habit: $e');
    }
  }

  Future<void> deleteHabit(int habitId) async {
    try {
      final categoryProvider = CategoryProvider();
      final habit = _habits.firstWhere((h) => h.id == habitId);
      final isCategoryStillUsed =
          _habits.any((h) => h.category == habit.category && h.id != habitId);

      if (!isCategoryStillUsed) {
        categoryProvider.removeCategory(habit.category);
      }

      await _habitRepository.deleteHabit(habitId);
      await fetchHabits();
    } catch (e) {
      debugPrint('Error deleting habit: $e');
    }
  }

  Future<void> clearAllHabits() async {
    try {
      final categoryProvider = CategoryProvider();
      categoryProvider.clearAllCategories();

      await _habitRepository.clearAllHabits();
      _habits.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing habits: $e');
    }
  }

  ///Edge Cases
  ///- No Habits: If _habits is empty, the method will return an empty list.
  ///- No Pending Habits: If no habits have ProgressStatus.notCompleted,
  ///the method will return an empty list.
  List<Category> getCategoriesWithPendingHabits() {
    final Set<Category> categoriesWithPendingHabits = {};

    for (final habit in _habits) {
      final hasPending = habit.progress.values.any(
        (status) => status == ProgressStatus.notCompleted,
      );

      if (hasPending) {
        categoriesWithPendingHabits.add(habit.category);
      }
    }

    return categoriesWithPendingHabits.toList();
  }

  List<Habit> getPendingHabits() {
    return _habits.where((habit) {
      return habit.progress.values.any(
        (status) => status == ProgressStatus.notCompleted,
      );
    }).toList();
  }

  List<Habit> getPendingHabitsByCategory(Category category) {
    return _habits.where((habit) {
      return habit.category.name == category.name &&
          habit.progress.values.any(
            (status) => status == ProgressStatus.notCompleted,
          );
    }).toList();
  }

  List<Habit> getHabitsByCategory(Category category) {
    return _habits.where((habit) {
      return habit.category.name == category.name;
    }).toList();
  }
}
