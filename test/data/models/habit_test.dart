import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clock/clock.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/data/models/category.dart';

void main() {
  final habit = Habit(
      id: 0,
      title: 'Test_Title',
      description: 'Test_Description',
      days: <DayOfWeek>[DayOfWeek.monday, DayOfWeek.thursday, DayOfWeek.sunday],
      time: TimeOfDay(hour: 13, minute: 34),
      progress: <DateTime, ProgressStatus>{
        DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
        DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
      },
      category: Category(
          name: 'Test_Category', color: Colors.brown, icon: Icons.work));

  group('Habit Constructor and getter functions', () {
    test(
        'Constructor should initialize correctly and progress should return the progress of the habit',
        () {
      expect(habit.id, 0);
      expect(habit.title, 'Test_Title');
      expect(habit.description, 'Test_Description');
      expect(
          habit.days, [DayOfWeek.monday, DayOfWeek.thursday, DayOfWeek.sunday]);
      expect(habit.time, TimeOfDay(hour: 13, minute: 34));
      expect(habit.progress, <DateTime, ProgressStatus>{
        DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
        DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
      });
      expect(
          habit.category,
          Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
    });

    test('Copy constructor should initialize correctly', () {
      final newHabit = Habit.from(habit);
      expect(newHabit.id, 0);
      expect(newHabit.title, 'Test_Title');
      expect(newHabit.description, 'Test_Description');
      expect(newHabit.days,
          [DayOfWeek.monday, DayOfWeek.thursday, DayOfWeek.sunday]);
      expect(newHabit.time, TimeOfDay(hour: 13, minute: 34));
      expect(newHabit.progress, <DateTime, ProgressStatus>{
        DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
        DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
      });
      expect(
          newHabit.category,
          Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
    });
    test(
        'defaultHabit should return a habit with default values for the attributes',
        () {
      final defaultHabit = Habit.defaultHabit();
      expect(defaultHabit.id, 0);
      expect(defaultHabit.title, '');
      expect(defaultHabit.description, '');
      expect(defaultHabit.days, []);
      expect(defaultHabit.time, TimeOfDay(hour: 0, minute: 0));
      expect(defaultHabit.progress, {});
      expect(defaultHabit.category, Category.defaultCategory());
    });
    test(
        'getDaysAsWeekdays should convert DayofWeek in int equal to DateTime .weekday',
        () {
      final habit_1 = Habit(
        id: 0,
        title: 'Test_Title',
        description: 'Test_Description',
        days: <DayOfWeek>[
          DayOfWeek.monday,
          DayOfWeek.wednesday,
          DayOfWeek.friday,
          DayOfWeek.sunday
        ],
        time: TimeOfDay(hour: 13, minute: 34),
        progress: <DateTime, ProgressStatus>{
          DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
          DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
        },
        category: Category(
            name: 'Test_Category', color: Colors.brown, icon: Icons.work),
      );
      expect(habit_1.getDaysAsWeekdays(), [1, 3, 5, 7]);
      final habit_2 = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.tuesday,
            DayOfWeek.thursday,
            DayOfWeek.saturday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: <DateTime, ProgressStatus>{
            DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
            DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
          },
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      expect(habit_2.getDaysAsWeekdays(), [2, 4, 6]);
    });
  });

  group('Test streak calculation', () {
    test('streak should return zero - last habit was not done', () {
      final mockClock = Clock.fixed(DateTime(2025, 01, 10, 17, 45));

      withClock(mockClock, () {
        final habit = Habit(
            id: 0,
            title: 'Test_Title',
            description: 'Test_Description',
            days: <DayOfWeek>[
              DayOfWeek.monday,
              DayOfWeek.thursday,
              DayOfWeek.sunday
            ],
            time: TimeOfDay(hour: 13, minute: 34),
            progress: <DateTime, ProgressStatus>{
              DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
              DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
            },
            category: Category(
                name: 'Test_Category', color: Colors.brown, icon: Icons.work));
        expect(habit.streak, 0);
      });
    });

    test('streak should return counted streak correctly', () {
      final mockClock = Clock.fixed(DateTime(2025, 01, 10, 17, 45));

      withClock(mockClock, () {
        final habit = Habit(
            id: 0,
            title: 'Test_Title',
            description: 'Test_Description',
            days: <DayOfWeek>[
              DayOfWeek.monday,
              DayOfWeek.thursday,
              DayOfWeek.sunday
            ],
            time: TimeOfDay(hour: 13, minute: 34),
            progress: <DateTime, ProgressStatus>{
              DateTime(2025, 1, 2, 23, 00): ProgressStatus.completed,
              DateTime(2025, 1, 5, 20, 10): ProgressStatus.notCompleted,
              DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
              DateTime(2025, 1, 8, 17, 20): ProgressStatus.completed,
            },
            category: Category(
                name: 'Test_Category', color: Colors.brown, icon: Icons.work));
        expect(habit.streak, 2);
      });
    });
  });
  group('Habit map conversion', () {
    test('toMap should return a map representation of the habit', () {
      final map = habit.toMap();

      expect(map['id'], 0);
      expect(map['title'], 'Test_Title');
      expect(map['description'], 'Test_Description');
      expect(map['days'], ['monday', 'thursday', 'sunday']);
      expect(map['time'], '13:34');
      expect(map['progress'], {
        '2025-01-06T15:06:00.000': 'completed',
        '2025-01-09T17:20:00.000': 'notCompleted'
      });
      expect(map['category'], {
        'name': 'Test_Category',
        // ignore: deprecated_member_use
        'color': Colors.brown.value,
        'icon': Icons.work.codePoint
      });
    });
    test('fromMap should create a Habit instance from a map', () {
      final map = {
        'id': 0,
        'title': 'Test_Title',
        'description': 'Test_Description',
        'days': ['monday', 'thursday', 'sunday'],
        'time': '13:34',
        'progress': {
          '2025-01-06T15:06:00.000': 'completed',
          '2025-01-09T17:20:00.000': 'notCompleted'
        },
        'category': {
          'name': 'Test_Category',
          // ignore: deprecated_member_use
          'color': Colors.brown.value,
          'icon': Icons.work.codePoint
        },
        // ignore: deprecated_member_use
        'color': Colors.red.value,
        'icon': Icons.stars.codePoint,
      };

      final habit = Habit.fromMap(map);

      expect(habit.id, 0);
      expect(habit.title, 'Test_Title');
      expect(habit.description, 'Test_Description');
      expect(
          habit.days, [DayOfWeek.monday, DayOfWeek.thursday, DayOfWeek.sunday]);
      expect(habit.time, TimeOfDay(hour: 13, minute: 34));
      expect(habit.progress, <DateTime, ProgressStatus>{
        DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
        DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
      });
      expect(
          habit.category,
          Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
    });
  });

  group('Edit habit', () {
    test(
        'copyWith should edit id, title, desc. and days attributes, others should be copied unchanged',
        () {
      final newHabit = habit.copyWith(
          id: 2,
          title: 'New title',
          description: 'New description',
          days: [DayOfWeek.tuesday]);
      expect(newHabit.id, 2);
      expect(newHabit.title, 'New title');
      expect(newHabit.description, 'New description');
      expect(newHabit.days, [DayOfWeek.tuesday]);
      expect(newHabit.time, TimeOfDay(hour: 13, minute: 34));
      expect(newHabit.progress, <DateTime, ProgressStatus>{
        DateTime(2025, 1, 6, 15, 6): ProgressStatus.completed,
        DateTime(2025, 1, 9, 17, 20): ProgressStatus.notCompleted
      });
      expect(
          newHabit.category,
          Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
    });

    test(
        'copyWith should edit time, progress and category attributes, others should be copied unchanged',
        () {
      final newHabit = habit.copyWith(
          time: TimeOfDay(hour: 09, minute: 20),
          progress: {
            DateTime(2025, 01, 06, 17, 59): ProgressStatus.notCompleted
          },
          category:
              Category(name: 'New', color: Colors.white, icon: Icons.star));
      expect(newHabit.id, 0);
      expect(newHabit.title, 'Test_Title');
      expect(newHabit.description, 'Test_Description');
      expect(newHabit.days,
          [DayOfWeek.monday, DayOfWeek.thursday, DayOfWeek.sunday]);
      expect(newHabit.time, TimeOfDay(hour: 09, minute: 20));
      expect(newHabit.progress,
          {DateTime(2025, 01, 06, 17, 59): ProgressStatus.notCompleted});
      expect(newHabit.category,
          Category(name: 'New', color: Colors.white, icon: Icons.star));
    });
  });
  group('Test progress functions of the habit class', () {
    test(
        'markAsCompleted should set the progress for date as completed because date matchs to days',
        () {
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsCompleted(DateTime(2025, 1, 6, 8, 55));
      habit.markAsCompleted(DateTime(2025, 1, 12, 19, 30));
      expect(habit.progress, {
        DateTime(2025, 1, 6): ProgressStatus.completed,
        DateTime(2025, 1, 12): ProgressStatus.completed
      });
    });
     test(
        'markAsCompleted should not set the progress for date as completed because date does not match to days',
        () {
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsCompleted(DateTime(2025, 1, 7, 8, 55));
      habit.markAsCompleted(DateTime(2025, 1, 11, 19, 30));
      expect(habit.progress, {});
    });
    test('markAsNotCompleted should set the progress for date as notCompleted',
        () {
      //keine Überprüfung, ob date zu days von habit passt. Gewollt oder fehlt?
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsNotCompleted(DateTime(2025, 1, 6, 8, 55));
      habit.markAsNotCompleted(DateTime(2025, 1, 9, 19, 30));
      expect(habit.progress, {
        DateTime(2025, 1, 6): ProgressStatus.notCompleted,
        DateTime(2025, 1, 9): ProgressStatus.notCompleted
      });
    });
    test(
        'isCompletedOnDate should return true if progress is set as completed for the date, otherwise false',
        () {
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsCompleted(DateTime(2025, 1, 6, 8, 55));
      habit.markAsNotCompleted(DateTime(2025, 1, 9, 19, 30));
      expect(habit.isCompletedOnDate(DateTime(2025, 1, 6)), true);
      expect(habit.isCompletedOnDate(DateTime(2025, 01, 09)), false);
    });
    test('toggleComplete should  toggle the progress status at date, mark as completed if date matchs to days', () {
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsCompleted(DateTime(2025, 1, 6, 8, 55));
      habit.markAsNotCompleted(DateTime(2025, 1, 9, 19, 30));
      habit.markAsNotCompleted(DateTime(2025, 1, 11, 06, 40));
      habit.toggleComplete(DateTime(2025, 1, 6, 10, 23));
      habit.toggleComplete(DateTime(2025, 1, 9, 23, 03));
      habit.toggleComplete(DateTime(2025, 1, 11, 08, 40));
      expect(habit.progress, {
        DateTime(2025, 1, 6): ProgressStatus.notCompleted,
        DateTime(2025, 1, 9): ProgressStatus.completed,
        DateTime(2025, 1, 11): ProgressStatus.notCompleted,
      });
    });
    test('toggleComplete should set the progress for the date to completed',
        () {
      final habit = Habit(
          id: 0,
          title: 'Test_Title',
          description: 'Test_Description',
          days: <DayOfWeek>[
            DayOfWeek.monday,
            DayOfWeek.thursday,
            DayOfWeek.sunday
          ],
          time: TimeOfDay(hour: 13, minute: 34),
          progress: {},
          category: Category(
              name: 'Test_Category', color: Colors.brown, icon: Icons.work));
      habit.markAsCompleted(DateTime(2025, 1, 6, 8, 55));
      habit.toggleComplete(DateTime(2025, 01, 02, 12, 12));
      expect(habit.progress, {
        DateTime(2025, 1, 6): ProgressStatus.completed,
        DateTime(2025, 01, 02): ProgressStatus.completed
      });
    });
  });
  group('Test functions to get the next date', () {
    test(
        'GetNextDueDate should return the next date the habit have to be done from now on',
        () {
      final mockNow = Clock.fixed(DateTime(2025, 01, 11, 17, 45));

      withClock(mockNow, () {
        final nextDate = habit.getNextDueDate();
        expect(nextDate, DateTime(2025, 01, 12, 13, 34));
      });
    });
  });
}
