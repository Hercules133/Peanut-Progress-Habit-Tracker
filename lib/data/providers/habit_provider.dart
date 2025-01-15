import 'package:flutter/material.dart';
import '/core/config/locator.dart';
import '/core/utils/enums/progress_status.dart';
import '/core/utils/enums/day_of_week.dart';
import '/data/models/category.dart';
import '/data/providers/category_provider.dart';
import '/data/repositories/habit_repository.dart';
import '/data/models/habit.dart';

/// A provider class for managing habits and interacting with the
/// [HabitRepository]. It extends [ChangeNotifier] to notify listeners when
/// habits or their states change.
class HabitProvider with ChangeNotifier {
  final HabitRepository _habitRepository;
  final categoryProvider = locator<CategoryProvider>();

  HabitProvider(this._habitRepository);

  List<Habit> _habits = [];
  List<Habit> _filteredHabits = [];
  List<Habit> get habits => isSearching ? _filteredHabits : _habits;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isSearching = false; // Status der Suchleiste
  String _query = ""; // Aktuelle Suchanfrage

  /// Fetches all habits from the repository and initializes categories for
  /// those habits. Notifies listeners when the data is loaded or an error
  /// occurs.
  Future<void> fetchHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _habitRepository.getAllHabits();
      categoryProvider.initializeCategories(_habits);
    } catch (e) {
      debugPrint('Error fetching habits: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void initializeProgressForAllHabits() {
    for (final habit in _habits) {
      habit.initializeProgress();
    }
    notifyListeners();
  }

  /// Toggles the search mode and clears the search query and filtered habits
  /// when turning off search.
  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      _query = "";
      _filteredHabits = [];
      debugPrint("toggleSearch Funktion ist gerufen worden");
      _filteredHabits = _habits; // Zeige alle Habits wieder an
    }
    notifyListeners();
  }

  /// Updates the search query and filters habits based on the query.
  ///
  /// [query] - The search term entered by the user.
  void updateQuery(String query) {
    _query = query;
    _filteredHabits = _habits
        .where(
            (habit) => habit.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    notifyListeners(); // UI über Änderungen informieren
  }

  /// Adds a new habit to the repository and updates the habit list.
  ///
  /// [habit] - The habit to add.
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

  /// Deletes a habit by its ID and removes its associated category if no other
  /// habits are using it.
  ///
  /// [habitId] - The ID of the habit to delete.
  Future<void> deleteHabit(int habitId) async {
    try {
      final habit = _habits.firstWhere((h) => h.id == habitId);
      final category = habit.category;
      await _habitRepository.deleteHabit(habitId);
      _habits.removeWhere((h) => h.id == habitId);

      final isCategoryStillUsed = _habits.any((h) => h.category == category);
      if (!isCategoryStillUsed && category.name != 'All') {
        categoryProvider.removeCategory(category);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting habit: $e');
    }
  }

  /// Clears all habits and resets the categories to default values.
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

  /// Returns a list of categories that have pending habits (habits that are
  /// not completed).
  ///
  /// Edge cases:
  /// - If `_habits` is empty, the method returns an empty list.
  /// - If no habits have pending status, the method returns an empty list.
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

  /// Returns a list of habits that are pending (not completed).
  List<Habit> getPendingHabits() {
    return _habits.where((habit) {
      return habit.progress.values.any(
        (status) => status == ProgressStatus.notCompleted,
      );
    }).toList();
  }

  /// Returns a list of pending habits for today, filtered by category.
  ///
  /// [category] - The category to filter the habits by.
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

  /// Returns a list of all habits that are scheduled for today and are not
  /// completed.
  List<Habit> getPendingHabitsForToday() {
    final today = DateTime.now();
    final weekday = DayOfWeek.values[today.weekday - 1];

    return _habits.where((habit) {
      bool isScheduledToday = habit.days.contains(weekday);
      bool isNotCompleted = !habit.isCompletedOnDate(today);

      return isScheduledToday && isNotCompleted;
    }).toList();
  }

  /// Returns a list of all habits.
  List<Habit> getAllHabits() {
    return _habits;
  }

  /// Returns a list of habits that belong to the specified category.
  ///
  /// [category] - The category to filter habits by.
  List<Habit> getHabitsByCategory(Category category) {
    return _habits.where((habit) {
      return habit.category.name == category.name;
    }).toList();
  }

  /// Returns a habit by its ID.
  ///
  /// [id] - The ID of the habit to retrieve.
  Habit getHabitById(int id) {
    return _habits.firstWhere((habit) => habit.id == id);
  }

  /// Toggles the completion status of a habit for a specific date.
  ///
  /// [habit] - The habit to toggle.
  /// [date] - The date for which the completion status should be toggled.
  void toggleHabitComplete(Habit habit, DateTime date) {
    habit.toggleComplete(date);
    _habitRepository.saveHabit(habit);
    notifyListeners();
  }

  /// Returns a list of habits that are scheduled for today.
  List<Habit> getHabitsForToday() {
    final today =
        DateTime.now().weekday; // Wochentag: 1 = Montag, ..., 7 = Sonntag
    return _habits.where((habit) {
      return habit.getDaysAsWeekdays().contains(today);
    }).toList();
  }
}
