import 'package:flutter/material.dart';
import '/data/models/category.dart';
import '/core/utils/enums/progress_status.dart';
import '/core/utils/enums/day_of_week.dart';
import '/data/models/date_only.dart';

class Habit {
  int id;
  String title;
  String description;
  List<DayOfWeek> days;
  TimeOfDay time;
  Map<DateTime, ProgressStatus> _progress;
  Category category;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.days,
    required this.time,
    required Map<DateTime, ProgressStatus> progress,
    required this.category,
  }) : _progress = progress;

  Map<DateTime, ProgressStatus> get progress => _progress;

  int get streak {
    int streakCount = 0;
    List<DateTime> sortedDates = _progress.keys.toList()..sort();

    for (var date in sortedDates.reversed) {
      if (_progress[date] == ProgressStatus.notCompleted) {
        date = DateTime(
          date.year,
          date.month,
          date.day + 1,
          time.hour,
          time.minute,
        );
        if (DateTime.now().isAfter(date)) {
          break;
        }
      } else if (_progress[date] == ProgressStatus.completed) {
        streakCount++;
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
      'progress': _progress
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
      progress: progress ?? _progress,
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
    _progress[dateOnly(date)] = ProgressStatus.completed;
  }

  void markAsNotCompleted(DateTime date) {
    _progress[dateOnly(date)] = ProgressStatus.notCompleted;
  }

  bool isCompletedOnDate(DateTime date) {
    return _progress[dateOnly(date)] == ProgressStatus.completed;
  }

  DateTime getNextDueDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? closestDate;

    for (var day in days) {
      var nextDate = _getNextDateForDay(day, today);
      nextDate = DateTime(
          nextDate.year, nextDate.month, nextDate.day, time.hour, time.minute);

      if (nextDate.isAfter(now) &&
          (closestDate == null || nextDate.isBefore(closestDate))) {
        closestDate = nextDate;
      }
    }

    if (closestDate == null) {
      var fallbackDay = days.first;
      closestDate = _getNextDateForDay(fallbackDay, today);
      closestDate = DateTime(closestDate.year, closestDate.month,
          closestDate.day, time.hour, time.minute);
    }

    return closestDate;
  }

  DateTime _getNextDateForDay(DayOfWeek day, DateTime today) {
    int daysToAdd = (day.index + 1 - today.weekday + 7) % 7;

    if (daysToAdd == 0 &&
        DateTime.now().isAfter(DateTime(
            today.year, today.month, today.day, time.hour, time.minute))) {
      daysToAdd = 7;
    }

    return today.add(Duration(days: daysToAdd));
  }

  void toggleComplete(DateTime date) {
    date = dateOnly(date);
    if (isCompletedOnDate(date)) {
      markAsNotCompleted(date);
    } else if (!isCompletedOnDate(date)) {
      markAsCompleted(date);
    }
  }
}
