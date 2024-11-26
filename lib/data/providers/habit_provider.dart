import 'package:flutter/material.dart';
import 'package:streaks/data/repositories/habit_repository.dart';
import 'package:streaks/data/models/habit.dart';

class HabitProvider with ChangeNotifier {
  final HabitRepository _habitRepository;

  HabitProvider(this._habitRepository);

  List<Habit> _habits = [];
  List<Habit> get habits => _habits;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _habitRepository.getAllHabits();
    } catch (e) {
      debugPrint('Error fetching habits: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHabit(Habit habit) async {
    try {
      await _habitRepository.saveHabit(habit);
      await fetchHabits();
    } catch (e) {
      debugPrint('Error saving habit: $e');
    }
  }

  Future<void> deleteHabit(int habitId) async {
    try {
      await _habitRepository.deleteHabit(habitId);
      await fetchHabits();
    } catch (e) {
      debugPrint('Error deleting habit: $e');
    }
  }

  Future<void> clearAllHabits() async {
    try {
      await _habitRepository.clearAllHabits();
      _habits.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing habits: $e');
    }
  }
}
