import 'package:flutter/material.dart';
import '/data/models/category.dart';
import '/data/models/habit.dart';

/// A provider class that manages a list of categories and the selected category
/// index. It extends [ChangeNotifier] to notify listeners of changes to
/// categories or the selected index.
class CategoryProvider with ChangeNotifier {
  final List<Category> _categories = [
    ...Category.defaultCategories(),
  ];

  int _selectedIndex = 0;

  /// A getter that returns the list of categories.
  List<Category> get categories => _categories;

  /// A getter that returns the currently selected category index.
  int get selectedIndex => _selectedIndex;

  /// Sets the selected category index and notifies listeners if the index has
  /// changed.
  ///
  /// [index] - The new index to set.
  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  /// Updates the selected category index and notifies listeners.
  ///
  /// [index] - The index to update the selected category to.
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Resets the selected category index to the default value (0) and notifies
  /// listeners.
  void resetSelectedIndex() {
    _selectedIndex = 0;
    notifyListeners();
  }

  /// Initializes the categories based on the habits provided.
  /// New categories from habits are added if they do not already exist.
  ///
  /// [habits] - A list of habits to extract categories from.
  void initializeCategories(List<Habit> habits) {
    List<Category> categories = habits
        .map((habit) => habit.category)
        .where((category) => !_categories.contains(category))
        .toList();

    for (Category category in categories) {
      addCategory(category);
    }
  }

  /// Adds a new category to the list of categories if it doesn't already exist.
  ///
  /// [category] - The category to add.
  void addCategory(Category category) {
    if (!_categories
        .any((existingCategory) => existingCategory.name == category.name)) {
      _categories.add(category);
      notifyListeners();
    }
  }

  /// Removes a category from the list of categories and notifies listeners.
  ///
  /// [category] - The category to remove.
  void removeCategory(Category category) {
    _categories.remove(category);
    notifyListeners();
  }

  /// Clears all categories and resets them to the default categories.
  void clearAllCategories() {
    _categories.clear();
    _categories.addAll(Category.defaultCategories());
    notifyListeners();
  }

  /// Checks if a given category exists in the list of categories.
  ///
  /// [category] - The category to check for existence.
  ///
  /// Returns `true` if the category exists, `false` otherwise.
  bool doesCategoryExist(Category category) {
    return _categories.contains(category);
  }
}
