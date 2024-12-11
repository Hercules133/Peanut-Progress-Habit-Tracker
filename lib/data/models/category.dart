import 'package:flutter/material.dart'; // for the icon class

class Category {
  final String name;
  final Color color;
  final IconData icon;

  Category({
    required this.name,
    required this.color,
    required this.icon,
  });

  static List<Category> defaultCategories() {
    return [
      Category(name: 'Default', color: Colors.green, icon: Icons.category),
      Category(
          name: 'Health', color: Colors.green, icon: Icons.health_and_safety),
      Category(name: 'Work', color: Colors.blue, icon: Icons.work),
      Category(name: 'Personal', color: Colors.orange, icon: Icons.person),
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
