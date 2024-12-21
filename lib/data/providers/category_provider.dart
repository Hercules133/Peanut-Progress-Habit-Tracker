import 'package:flutter/material.dart';
import '/data/models/category.dart';
import '/data/models/habit.dart';

class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    ...Category.defaultCategories(),
  ];

  List<Category> get categories => _categories;

  void initilizeCategories(List<Habit> habits) {
    List<Category> categories = habits
        .map((habit) => habit.category)
        .where((category) => !_categories.contains(category))
        .toList();

    for (Category category in categories) {
      addCategory(category);
    }
  }

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void removeCategory(Category category) {
    _categories.remove(category);
    notifyListeners();
  }

  void clearAllCategories() {
    _categories.clear();
    _categories.addAll(Category.defaultCategories());
    notifyListeners();
  }

  bool doesCategoryExist(Category category) {
    return _categories.contains(category);
  }
}
