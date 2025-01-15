import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clock/clock.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/core/utils/enums/progress_status.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/date_only.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/repositories/habit_repository.dart';
import 'package:provider_test/provider_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  testProvider<HabitProvider>("Constructor should initialize correctly",
      build: () => HabitProvider(locator<HabitRepository>()),
      verify: (provider) {
        expect(provider.isSearching, false);
        expect(provider.query, "");
        expect(provider.habits, []);
      });

  testProvider<HabitProvider>(
    "fetchHabits should update the habits",
    build: () => HabitProvider(locator<HabitRepository>()),
    seed: (provider) => provider.habitRepository.saveHabit(
      Habit(
        id: 0,
        title: 'test1',
        description: '',
        days: [DayOfWeek.monday],
        time: const TimeOfDay(hour: 0, minute: 0),
        progress: {},
        category: Category(
          name: 'Test1',
          color: Colors.red,
          icon: Icons.stars,
        ),
      ),
    ),
    act: (provider) => provider.fetchHabits(),
    verify: (provider) {
      expect(provider.habits.isNotEmpty, true);
      expect(provider.isLoading, false);
    },
  );

  testProvider<HabitProvider>(
    "toggleSearch should update the search status",
    build: () => HabitProvider(locator<HabitRepository>()),
    act: (provider) => provider.toggleSearch(),
    verify: (provider) {
      expect(provider.isSearching, true);
    },
  );

  testProvider<HabitProvider>(
    "updateQuery should update the query and filteredHabits",
    build: () => HabitProvider(locator<HabitRepository>()),
    seed: (provider) {
      provider.habitRepository.saveHabit(
        Habit(
          id: 0,
          title: 'test1',
          description: '',
          days: [DayOfWeek.monday],
          time: const TimeOfDay(hour: 0, minute: 0),
          progress: {},
          category: Category(
            name: 'Test1',
            color: Colors.red,
            icon: Icons.stars,
          ),
        ),
      );
      provider.habitRepository.saveHabit(
        Habit(
          id: 1,
          title: 'hallo',
          description: '',
          days: [DayOfWeek.monday],
          time: const TimeOfDay(hour: 0, minute: 0),
          progress: {},
          category: Category(
            name: 'Test1',
            color: Colors.red,
            icon: Icons.stars,
          ),
        ),
      );
      provider.fetchHabits();
    },
    act: (provider) => provider.updateQuery('test'),
    verify: (provider) {
      expect(provider.query, 'test');
      expect(provider.filteredHabits.isNotEmpty, true);
      expect(provider.filteredHabits.length, 1);
      expect(provider.habits.length, 2);
      provider.clearAllHabits();
    },
  );

  testProvider<HabitProvider>(
    "toggleSearch from true to false should stop the filtering",
    build: () => HabitProvider(locator<HabitRepository>()),
    seed: (provider) {
      provider.habitRepository.saveHabit(
        Habit(
          id: 0,
          title: 'test1',
          description: '',
          days: [DayOfWeek.monday],
          time: const TimeOfDay(hour: 0, minute: 0),
          progress: {},
          category: Category(
            name: 'Test1',
            color: Colors.red,
            icon: Icons.stars,
          ),
        ),
      );

      provider.fetchHabits();
      provider.isSearching = true;
      provider.updateQuery('hallo');
    },
    act: (provider) => provider.toggleSearch(),
    verify: (provider) {
      expect(provider.isSearching, false);
      expect(provider.query, '');
      expect(provider.filteredHabits.length, 1);
      provider.clearAllHabits();
    },
  );

  testProvider<HabitProvider>(
    "addHabit should add a habit",
    build: () => HabitProvider(locator<HabitRepository>()),
    seed: (provider) {
      provider.categoryProvider.addCategory(Category(
        name: 'Test1',
        color: Colors.red,
        icon: Icons.stars,
      ));
    },
    act: (provider) => provider.addHabit(
      Habit(
        id: 0,
        title: 'test1',
        description: '',
        days: [DayOfWeek.monday],
        time: const TimeOfDay(hour: 0, minute: 0),
        progress: {},
        category: Category(
          name: 'Test1',
          color: Colors.red,
          icon: Icons.stars,
        ),
      ),
    ),
    verify: (provider) async {
      expect(provider.habits.length, 1);
      Future<List<Habit>> habits = provider.habitRepository.getAllHabits();
      List<Habit> habitList = await habits;
      expect(habitList.length, 1);
    },
  );

  testProvider<HabitProvider>("deleteHabit removes Habit with given id ",
      build: () => HabitProvider(locator<HabitRepository>()),
      seed: (provider) {
        provider.addHabit(
          Habit(
            id: 0,
            title: 'test1',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {},
            category: Category(
              name: 'Test1',
              color: Colors.red,
              icon: Icons.stars,
            ),
          ),
        );
        provider.addHabit(
          Habit(
            id: 1,
            title: 'test2',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {},
            category: Category(
              name: 'Test1',
              color: Colors.red,
              icon: Icons.stars,
            ),
          ),
        );
      },
      verify: (provider) async {
        await provider.deleteHabit(0);
        expect(provider.habits.length, 1);
        expect(provider.habits[0].id, 1);
        Future<List<Habit>> habits = provider.habitRepository.getAllHabits();
        List<Habit> habitList = await habits;
        expect(habitList.length, 1);
        expect(habitList[0].id, 1);
      });
  testProvider<HabitProvider>("clearAllHabits removes all Habits",
      build: () => HabitProvider(locator<HabitRepository>()),
      seed: (provider) {
        provider.addHabit(
          Habit(
            id: 0,
            title: 'test1',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {},
            category: Category(
              name: 'Test1',
              color: Colors.red,
              icon: Icons.stars,
            ),
          ),
        );
        provider.addHabit(
          Habit(
            id: 1,
            title: 'test2',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {},
            category: Category(
              name: 'Test1',
              color: Colors.red,
              icon: Icons.stars,
            ),
          ),
        );
      },
      verify: (provider) async {
        await provider.clearAllHabits();
        expect(provider.habits.isEmpty, true);
        Future<List<Habit>> habits = provider.habitRepository.getAllHabits();
        List<Habit> habitList = await habits;
        expect(habitList.isEmpty, true);
      });

  group("functions regarding pending Habits", () {
    late HabitProvider provider; 
    late Category category1;
    late Category category2;
    late Category category3;
    late Clock mockClock; 

    setUp(() {
      provider = HabitProvider(locator<HabitRepository>());
      mockClock = Clock.fixed(DateTime(2025, 01, 6, 17, 45));

      withClock(mockClock, () {
      category1 = Category(
        name: 'Test1',
        color: Colors.red,
        icon: Icons.stars,
      );
      category2 = Category(
        name: 'Test2',
        color: Colors.blue,
        icon: Icons.headphones,
      );
      category3 = Category(
        name: 'Test3',
        color: Colors.green,
        icon: Icons.person,
      );

      provider.addHabit(
        Habit(
            id: 0,
            title: 'test1',
            description: '',
            days: [
              DayOfWeek.monday,
              DayOfWeek.tuesday,
              DayOfWeek.wednesday,
              DayOfWeek.thursday,
              DayOfWeek.friday,
              DayOfWeek.saturday,
              DayOfWeek.sunday
            ],
            time: const TimeOfDay(hour: 10, minute: 0),
            progress: {dateOnly(mockClock.now()): ProgressStatus.notCompleted},
            category: category1),
      );
      provider.addHabit(
        Habit(
            id: 1,
            title: 'test2',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {dateOnly(mockClock.now()): ProgressStatus.completed},
            category: category1),
      );

      provider.addHabit(
        Habit(
            id: 2,
            title: 'test3',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {dateOnly(mockClock.now()): ProgressStatus.completed},
            category: category2),
      );
      provider.addHabit(
        Habit(
            id: 3,
            title: 'test4',
            description: '',
            days: [DayOfWeek.monday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {dateOnly(mockClock.now()): ProgressStatus.notCompleted},
            category: category1),
      );
      provider.addHabit(
        Habit(
            id: 4,
            title: 'test5',
            description: '',
            days: [DayOfWeek.monday, DayOfWeek.tuesday],
            time: const TimeOfDay(hour: 10, minute: 0),
            progress: {
              dateOnly(mockClock.now()): ProgressStatus.completed,
              dateOnly(mockClock.daysFromNow(1)): ProgressStatus.notCompleted
            },
            category: category1),
      );
      provider.addHabit(
        Habit(
            id: 5,
            title: 'test6',
            description: '',
            days: [DayOfWeek.monday, DayOfWeek.tuesday],
            time: const TimeOfDay(hour: 0, minute: 0),
            progress: {
              dateOnly(mockClock.now()): ProgressStatus.notCompleted,
              dateOnly(mockClock.daysFromNow(1)): ProgressStatus.notCompleted
            },
            category: category3),
      );});
    });
    testProvider<HabitProvider>(
      "getCategoriesWithPendingHabits should return categories with pending habits",
      build: () => provider,
      verify: (provider) {
        final categoriesWithPendingHabits =
            provider.getCategoriesWithPendingHabits();
        expect(categoriesWithPendingHabits.length, 2);
        expect(categoriesWithPendingHabits.contains(category1), true);
        expect(categoriesWithPendingHabits.contains(category2), false);
        expect(categoriesWithPendingHabits.contains(category3), true);
      }
    );

    testProvider(
        "getPendingHabitsForTodayByCategory should return habits with pending status for today",
        build: () => provider,
        verify: (provider) {
          withClock(mockClock, (){
          final pendingHabits =
              provider.getPendingHabitsForTodayByCategory(category1);
          expect(pendingHabits.length, 2);
          expect(pendingHabits[0].id, 0);
          expect(pendingHabits[1].id, 3);
          });
        });

    testProvider(
      "getPendingHabitsForToday should return habits with pending status for today",
      build: () => provider,
      verify: (provider) {
        withClock(mockClock,(){
        final pendingHabits = provider.getPendingHabitsForToday();
        expect(pendingHabits.length, 3);
        expect(pendingHabits[0].id, 0);
        expect(pendingHabits[1].id, 3);
        expect(pendingHabits[2].id, 5);
        }); 
      },
    );

    testProvider(
      "getAllHabits should return all habits",
      build: () => provider,
      verify: (provider) {
        final allHabits = provider.getAllHabits();
        expect(allHabits.length, 6);
      },
    );

    testProvider("getHabitsByCategory should return all habits with the given category",
     build: () => provider,
      verify: (provider) {
        final habits = provider.getHabitsByCategory(category1);
        expect(habits.length, 4);
        expect(habits[0].id, 0);
        expect(habits[1].id, 1);
        expect(habits[2].id, 3);
        expect(habits[3].id, 4);
      });

    testProvider("getHabitById should return the habit with the given id",
      build: () => provider,
        verify: (provider) {
          final habit = provider.getHabitById(0);
          expect(habit.id, 0);
        }); 

    testProvider("toggleHabitComplete",
     build: ()=> provider,
     verify: (provider){
      withClock(mockClock, () {
       final habit = provider.getHabitById(0);
       provider.toggleHabitComplete(habit, mockClock.now());
       final updatedHabit = provider.getHabitById(0); 
       expect(updatedHabit.progress[dateOnly(mockClock.now())], ProgressStatus.completed);
      });
     }); 
    
    testProvider("getHabitsForToday should get all Habits for today ",
     build: ()=> provider,
      verify: (provider){
         withClock(mockClock, () {
        final habits = provider.getHabitsForToday();

        expect(habits.length, 6);
        expect(habits[0].id, 0);
        expect(habits[1].id, 1);
        expect(habits[2].id, 2);
        expect(habits[3].id, 3);
        expect(habits[4].id, 4);
        expect(habits[5].id, 5);
         });
      });
  });
}
