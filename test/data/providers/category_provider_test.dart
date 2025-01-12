import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/config/locator.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:provider_test/provider_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
    setupLocator();
  });

  testProvider<CategoryProvider>("Constructor should initialize correctly",
      build: () => CategoryProvider(),
      verify: (provider) {
        expect(provider.categories, Category.defaultCategories());
        expect(provider.selectedIndex, 0);
      });

  testProvider<CategoryProvider>(
    "setSelectedIndex should set the selected Index",
    build: () => CategoryProvider(),
    act: (provider) => provider.setSelectedIndex(2),
    verify: (provider) {
      expect(provider.selectedIndex, 2);
    },
  );

  testProvider<CategoryProvider>(
    "updateSelectedIndex should update the selected Index",
    build: () => CategoryProvider(),
    seed: (provider) => provider.setSelectedIndex(1),
    act: (provider) => provider.updateSelectedIndex(2),
    verify: (provider) {
      expect(provider.selectedIndex, 2);
    },
  );

  testProvider<CategoryProvider>(
    "resetSelectedIndex should reset the selected Index",
    build: () => CategoryProvider(),
    seed: (provider) => provider.setSelectedIndex(1),
    act: (provider) => provider.resetSelectedIndex(),
    verify: (provider) {
      expect(provider.selectedIndex, 0);
    },
  );

  testProvider<CategoryProvider>(
    "initializeCategories should set new categories",
    build: () => CategoryProvider(),
    act: (provider) => provider.initializeCategories([
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
      Habit(
        id: 1,
        title: 'test2',
        description: '',
        days: [DayOfWeek.saturday],
        time: const TimeOfDay(hour: 10, minute: 0),
        progress: {},
        category: Category(
          name: 'Test2',
          color: Colors.blue,
          icon: Icons.headphones,
        ),
      ),
    ]),
    verify: (provider) {
      expect(provider.categories.length, 3);
      expect(provider.categories[1].name, 'Test1');
      expect(provider.categories[2].name, 'Test2');
    },
  );

  testProvider<CategoryProvider>(
    "initializeCategories should not add duplicate categories",
    build: () => CategoryProvider(),
    seed: (provider) => provider.initializeCategories([
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
      Habit(
        id: 1,
        title: 'test2',
        description: '',
        days: [DayOfWeek.saturday],
        time: const TimeOfDay(hour: 10, minute: 0),
        progress: {},
        category: Category(
          name: 'Test2',
          color: Colors.blue,
          icon: Icons.headphones,
        ),
      ),
    ]),
    act: (provider) => provider.initializeCategories([
      Habit(
        id: 3,
        title: 'test3',
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
    ]),
    verify: (provider) {
      expect(provider.categories.length, 3);
    },
  );

  testProvider<CategoryProvider>(
    "addCategory should add a new category",
    build: () => CategoryProvider(),
    act: (provider) => provider.addCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    verify: (provider) {
      expect(provider.categories.length, 2);
      expect(provider.categories[1].name, 'Test');
    },
  );

  testProvider<CategoryProvider>(
    "addCategory should not add a duplicate category",
    build: () => CategoryProvider(),
    seed: (provider) => provider.addCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    act: (provider) => provider.addCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    verify: (provider) {
      expect(provider.categories.length, 2);
    },
  );

  testProvider<CategoryProvider>(
    "removeCategory should remove a category",
    build: () => CategoryProvider(),
    seed: (provider) => provider.addCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    act: (provider) => provider.removeCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    verify: (provider) {
      expect(provider.categories.length, 1);
    },
  );

  testProvider<CategoryProvider>(
    "clearAllCategories should reset the categories",
    build: () => CategoryProvider(),
    seed: (provider) => provider.initializeCategories([
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
      Habit(
        id: 1,
        title: 'test2',
        description: '',
        days: [DayOfWeek.saturday],
        time: const TimeOfDay(hour: 10, minute: 0),
        progress: {},
        category: Category(
          name: 'Test2',
          color: Colors.blue,
          icon: Icons.headphones,
        ),
      ),
    ]),
    act: (provider) => provider.clearAllCategories(),
    verify: (provider) {
      expect(provider.categories.length, 1);
      expect(provider.categories[0].name, 'All');
    },
  );

  testProvider<CategoryProvider>(
    "doesCategoryExist should return true if the category exists",
    build: () => CategoryProvider(),
    seed: (provider) => provider.addCategory(Category(
      name: 'Test',
      color: Colors.red,
      icon: Icons.stars,
    )),
    verify: (provider) {
      expect(provider.doesCategoryExist(Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      )), true);
    },
  );

  testProvider<CategoryProvider>(
    "doesCategoryExist should return false if the category does not exist",
    build: () => CategoryProvider(),
    verify: (provider) {
      expect(provider.doesCategoryExist(Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      )), false);
    },
  );
}
