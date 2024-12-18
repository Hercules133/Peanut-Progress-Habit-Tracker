import 'package:flutter/material.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/core/utils/enums/day_of_week.dart';
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

  // ignore: unnecessary_getters_setters
  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
  }

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
      _filteredHabits = [];
      debugPrint("toggleSearch Funktion ist gerufen worden");
      _filteredHabits = _habits; // Zeige alle Habits wieder an
    }
    notifyListeners();
  }

  void updateQuery(String query) {
    _query = query;
    _filteredHabits = _habits
        .where(
            (habit) => habit.title.toLowerCase().contains(_query.toLowerCase()))
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

  List<Habit> getPendingHabitsForTodayByCategory(Category category) {
    final today = DateTime.now().weekday;
    return _habits.where((habit) {
      final isToday = habit.days.contains(DayOfWeek.values[today - 1]);
      final isPending = habit.progress.values.any(
            (status) => status == ProgressStatus.notCompleted,
      );
      return habit.category.name == category.name && isToday && isPending;
    }).toList();
  }

  List<Habit> getPendingHabitsForToday() {
    final today = DateTime.now();
    final weekday = DayOfWeek.values[today.weekday - 1];

    return _habits.where((habit) {
      bool isScheduledToday = habit.days.contains(weekday);
      bool isNotCompleted = !habit.isCompletedOnDate(today);

      return isScheduledToday && isNotCompleted;
    }).toList();
  }


  List<Habit> getAllHabits() {
    return _habits;
  }

  List<Habit> getHabitsByCategory(Category category) {
    return _habits.where((habit) {
      return habit.category.name == category.name;
    }).toList();
  }

  Habit getHabitById(int id) {
    return _habits.firstWhere((habit) => habit.id == id);
  }

  void toggleHabitComplete(Habit habit, DateTime date) {
    habit.toggleComplete(date);
    notifyListeners();
  }

  List<Habit> getHabitsForToday() {
    final today = DateTime.now().weekday; // Wochentag: 1 = Montag, ..., 7 = Sonntag
    return _habits.where((habit) {
      return habit.days.contains(today); // days ist die Liste der Wochentage
    }).toList();
  }
}
