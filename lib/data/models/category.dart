import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/color_ex.dart';

/// A model class representing a category in the application.
///
/// The `Category` class holds information about a category, including its name,
/// color, icon, and whether it is a default category.
///
/// ### Properties:
/// - [name]: The name of the category.
/// - [color]: The color associated with the category.
/// - [icon]: The icon representing the category.
/// - [isDefault]: A boolean indicating whether the category is a default category.
///
class Category {
  final String name;
  final Color color;
  final IconData icon;
  final bool isDefault;

  Category({
    required this.name,
    required this.color,
    required this.icon,
    this.isDefault = false,
  });

  /// Returns a list of default categories.
  ///
  /// This method provides a list of predefined default categories.
  static List<Category> defaultCategories() {
    return [
      Category(
        name: 'All',
        color: const Color(0xFFC58F70),
        icon: Icons.list_alt,
        isDefault: true,
      ),
    ];
  }

  /// Returns the default category.
  ///
  /// This factory constructor returns the first category from the list of
  /// default categories.
  factory Category.defaultCategory() {
    return defaultCategories().first;
  }

  /// Converts the `Category` instance to a map.
  ///
  /// This method is useful for serializing the category to a map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.toARGB32,
      'icon': icon.codePoint,
    };
  }

  /// Creates a `Category` instance from a map.
  ///
  /// This factory constructor is useful for deserializing a category from a map.
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      color: Color(map['color']),
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Category) return false;

    bool name = this.name == other.name;
    bool color = this.color.toARGB32 == other.color.toARGB32;
    bool icon = this.icon == other.icon;

    return name && color && icon;
  }

  @override
  int get hashCode => Object.hash(name, color, icon);
}
