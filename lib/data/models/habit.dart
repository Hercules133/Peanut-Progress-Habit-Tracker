import 'package:flutter/material.dart';
import 'package:streaks/data/models/category.dart';

class Habit {
  String _title;
  String _description;
  List<int> _days; // [0, 1, 2, 3, 4, 5, 6] -> if only mo and tue, then [0, 1]
  TimeOfDay _time; // dateTime hour and minute (class timeofday)
  bool _isCompleted;
  Category _category;
  List<bool> _progress;
  late int _id = 0;
  int _streak = 0;

  Habit({
    required String title,
    required String description,
    required List<int> days,
    required TimeOfDay time,
    bool isCompleted = false,
    required Category category,
  })  : _title = title,
        _description = description,
        _days = days,
        _time = time,
        _isCompleted = isCompleted,
        _category = category,
        _progress = List.generate(7, (index) => false) {
    _id = _id++;
  }

  // Getter for streak
  int get streak => _streak;

  // Getter for title
  String get title => _title;

  // Setter for title
  set title(String value) {
    if (value.isEmpty) {
      throw ArgumentError("You must specify a title!");
    }
    _title = value;
  }

  // Getter for description
  String get description => _description;

  // Setter for description
  set description(String value) {
    if (value.length > 150) {
      throw ArgumentError("Description cannot be longer than 150 characters!");
    }
    _description = value;
  }

  // Getter for days
  List<int> get days => _days;

  // Setter for days
  set days(List<int> value) {
    if (value.isEmpty) {
      throw ArgumentError("You have to choose the days!");
    }
    _days = value;
  }

  // Getter for time
  TimeOfDay get time => _time;

  // Setter for time
  set time(TimeOfDay value) {
    _time = value;
  }

  // Getter for isCompleted
  bool get isCompleted => _isCompleted;

  // Setter for isCompleted
  set isCompleted(bool value) {
    _isCompleted = value;
  }

  // Getter for category
  Category get category => _category;

  // Setter for category
  set category(Category value) {
    if (value == null) {
      throw ArgumentError("You have to choose a category!");
    }
    _category = value;
  }

  // Mark days as completed in the progress list
  void markDayAsCompleted(int weekday) {
    if (!_days.contains(weekday)) {
      throw ArgumentError("This day was not chosen for this habit!");
    }
    _progress[weekday] = true;
    _updateStreak(); // Update streak after marking a day
  }

  // Check, if the habit is done on a specific day
  bool isDayCompleted(int weekday) {
    if (!_days.contains(weekday)) {
      return false;
    }
    return _progress[weekday];
  }

  // Get progress for all days
  Map<int, bool> getProgress() {
    return {
      for (var day in _days) day: _progress[day],
    };
  }

  // Update streak logic
  void _updateStreak() {
    for (int day in _days) {
      if (!_progress[day]) {
        _streak = 0; // Reset streak if any planned day is not completed
        return;
      }
    }
    _streak++; // Increase streak if all planned days are completed
  }
}
