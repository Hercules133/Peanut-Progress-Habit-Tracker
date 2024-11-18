// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:streaks/data/repositories/habit_repository.dart';

// TODO: Update add datatypes to Habit model and also update the HabitRepository
// to use the Habit model instead of Maps

class HabitProvider with ChangeNotifier {
  final HabitRepository _habitRepository;

  HabitProvider(this._habitRepository);

  List<Map<String, dynamic>> _habits = [];
  List<Map<String, dynamic>> get habits => _habits;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchHabits() async {
    _isLoading = true;
    notifyListeners();

    try {
      _habits = await _habitRepository.getAllHabits();
    } catch (e) {
      print('Error fetching habits: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHabit(Map<String, dynamic> habitData) async {
    try {
      await _habitRepository.saveHabit(habitData);
      await fetchHabits();
    } catch (e) {
      print('Error saving habit: $e');
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await _habitRepository.deleteHabit(habitId);
      await fetchHabits();
    } catch (e) {
      print('Error deleting habit: $e');
    }
  }

  Future<void> clearAllHabits() async {
    try {
      await _habitRepository.clearAllHabits();
      _habits.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing habits: $e');
    }
  }
}
