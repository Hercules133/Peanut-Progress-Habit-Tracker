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
        name: 'All',
        color: const Color(0xFFC58F70),
        icon: Icons.list_alt,
        isDefault: true,
      ),
    ];
  }

  factory Category.defaultCategory() {
    return defaultCategories().first;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      // ignore: deprecated_member_use
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
    // ignore: deprecated_member_use
    bool color = this.color.value == other.color.value;
    bool icon = this.icon == other.icon;

    return name && color && icon;
  }

  @override
  int get hashCode => Object.hash(name, color, icon);
}