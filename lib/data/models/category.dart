import 'package:flutter/material.dart';

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

  static List<Category> defaultCategories() {
    return [
      Category(
          name: 'Health',
          color: const Color(0xFFD3B09C),
          icon: Icons.health_and_safety,
          isDefault: true),
      Category(
          name: 'Work',
          color: const Color(0xFFD6A579),
          icon: Icons.work,
          isDefault: true),
      Category(
          name: 'Personal',
          color: const Color(0xFFE09165),
          icon: Icons.person,
          isDefault: true),
    ];
  }

  factory Category.defaultCategory() {
    return defaultCategories().first;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

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
    bool color = this.color.value == other.color.value;
    bool icon = this.icon == other.icon;

    return name && color && icon;
  }

  @override
  int get hashCode => Object.hash(name, color, icon);
}
