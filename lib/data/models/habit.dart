import 'dart:math';

import 'package:streaks/data/models/category.dart';

// habbit id ✅
// category -> enum, seperate class ✅
// time -> days and time ✅
// iscompleted (days?) -> 2d array (?)
// [[Mo, false], [Tu, false], [We, false], [Th, false], [Fr, false], [Sa, false], [Su, false]]

class Habit {
  // Used Id-s
  static final Set<int> _usedIds = {};

  String _title;
  String _description;
  List<String> _days; // [Mo, Tu, We, Th, Fr, Sa, Su]
  String _time;
  bool _isCompleted;
  Category _category;
  late int _id;

  Habit({
    required String title,
    required String description,
    required List<String> days,
    required String time,
    bool isCompleted = false,
    required Category category,
  })  : _title = title,
        _description = description,
        _days = days,
        _time = time,
        _isCompleted = isCompleted,
        _category = category {
    _id = generateId();
  }

  // Generate random number
  static int generateId() {
    final random = Random();
    int newId;

    do {
      newId = random.nextInt(10000000);
    } while (_usedIds.contains(newId));

    _usedIds.add(newId);
    return newId;
  }

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
  List<String> get days => _days;

  // Setter for days
  set days(List<String> value) {
    if (value.isEmpty) {
      throw ArgumentError("You have to choose the days!");
    }
    _days = value;
  }

  // Getter for time
  String get time => _time;

  // Setter for time
  set time(String value) {
    if (!_isValidTimeFormat(value)) {
      throw ArgumentError(
          "Time must be in the format HH:mm, where HH is 00-23 and mm is 00-59.");
    }
    _time = value;
  }

  // Time format checker
  bool _isValidTimeFormat(String time) {
    final timeRegex = RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$');
    return timeRegex.hasMatch(time);
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
}
