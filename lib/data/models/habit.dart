import 'package:flutter/material.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/core/utils/enums/progress_status.dart';
import 'package:streaks/core/utils/enums/day_of_week.dart';

class Habit {
  int id;
  String title;
  String description;
  List<DayOfWeek> days;
  TimeOfDay time;
  Map<DateTime, ProgressStatus> progress;
  Category category;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.days,
    required this.time,
    required this.progress,
    required this.category,
  });

  int get streak {
    int streakCount = 0;
    List<DateTime> sortedDates = progress.keys.toList()..sort();

    for (var date in sortedDates.reversed) {
      if (progress[date] == ProgressStatus.completed) {
        streakCount++;
      } else {
        break;
      }
    }
    return streakCount;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'days': days.map((day) => day.name).toList(),
      'time': '${time.hour}:${time.minute}',
      'progress': progress
          .map((key, value) => MapEntry(key.toIso8601String(), value.name)),
      'category': category.toMap(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      days: (map['days'] as List<dynamic>)
          .map((day) => DayOfWeek.values.firstWhere((e) => e.name == day))
          .toList(),
      time: TimeOfDay(
        hour: int.parse(map['time'].split(':')[0]),
        minute: int.parse(map['time'].split(':')[1]),
      ),
      progress: (map['progress'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          DateTime.parse(key),
          ProgressStatus.values.firstWhere((e) => e.name == value),
        ),
      ),
      category: Category.fromMap(map['category']),
    );
  }

  Habit copyWith({
    int? id,
    String? title,
    String? description,
    List<DayOfWeek>? days,
    TimeOfDay? time,
    Map<DateTime, ProgressStatus>? progress,
    Category? category,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      days: days ?? this.days,
      time: time ?? this.time,
      progress: progress ?? this.progress,
      category: category ?? this.category,
    );
  }

  factory Habit.defaultHabit() {
    return Habit(
      id: 0,
      title: '',
      description: '',
      days: [],
      time: const TimeOfDay(hour: 0, minute: 0),
      progress: {},
      category: Category.defaultCategory(),
    );
  }

  void markAsCompleted(DateTime date) {
    progress[date] = ProgressStatus.completed;
  }

  void markAsNotCompleted(DateTime date) {
    progress[date] = ProgressStatus.notCompleted;
  }

  bool isCompletedOnDate(DateTime date) {
    return progress[date] == ProgressStatus.completed;
  }

  DateTime? getNextDueDate() {
    final today = DateTime.now();
    for (var day in days) {
      var nextDate = _getNextDateForDay(day, today);
      if (nextDate.isAfter(today)) {
        return nextDate;
      }
    }
    return null;
  }

  DateTime _getNextDateForDay(DayOfWeek day, DateTime today) {
    int daysToAdd = (day.index - today.weekday + 7) % 7;
    return today.add(Duration(days: daysToAdd));
  }
}
