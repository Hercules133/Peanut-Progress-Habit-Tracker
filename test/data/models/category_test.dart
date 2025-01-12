import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peanutprogress/core/utils/color_ex.dart';
import 'package:peanutprogress/data/models/category.dart';

void main() {
  group('Category Constructor and Default Categorys', () {
    test('Constructor should initialize correctly', () {
      final category = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      expect(category.name, 'Test');
      expect(category.color, Colors.red);
      expect(category.icon, Icons.stars);
      expect(category.isDefault, false);
    });

    test('defaultCategories should return a list of default categories', () {
      final categories = Category.defaultCategories();

      // expect(categories.length, 3);
      // expect(categories[0].name, 'Health');
      // expect(categories[1].name, 'Work');
      // expect(categories[2].name, 'Personal');
      expect(categories.length, 1);
      expect(categories[0].name, 'All');
    });

    test('defaultCategories should be default', () {
      final categories = Category.defaultCategories();

      // expect(categories.length, 3);
      // expect(categories[0].isDefault, true);
      // expect(categories[1].isDefault, true);
      // expect(categories[2].isDefault, true);
      expect(categories.length, 1);
      expect(categories[0].isDefault, true);
    });

    test('defaultCategory should return the first default category', () {
      final category = Category.defaultCategory();

      expect(category.name, 'All');
      expect(category.color, const Color(0xFFC58F70));
      expect(category.icon, Icons.list_alt);
      expect(category.isDefault, true);
    });
  });
  group('Catgeory map conversion', () {
    test('toMap should return a map representation of the category', () {
      final category =
          Category(name: 'Test', color: Colors.red, icon: Icons.stars);

      final map = category.toMap();

      expect(map['name'], 'Test');
      expect(map['color'], Colors.red.toARGB32);
      expect(map['icon'], Icons.stars.codePoint);
    });

    test('fromMap should create a Category instance from a map', () {
      final map = {
        'name': 'Test',
        'color': Colors.red.toARGB32,
        'icon': Icons.stars.codePoint,
      };

      final category = Category.fromMap(map);

      expect(category.name, 'Test');
      expect(category.color.toARGB32, Colors.red.toARGB32);
      expect(category.icon, Icons.stars);
    });
    test('fromMap should throw an error for invalid map structure', () {
      final invalidMap = {
        'name': 'Test',
        // 'color' key is missing
        'icon': Icons.stars.codePoint,
      };

      expect(() => Category.fromMap(invalidMap), throwsA(isA<TypeError>()));
    });

    test('toMap and fromMap should create identical category instance', () {
      final category = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      final map = category.toMap();
      final recreatedCategory = Category.fromMap(map);

      expect(recreatedCategory, equals(category));
    });
  });

  group('equality and hashing', () {
    test('equality operator should compare categories correctly', () {
      final category1 = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      final category2 = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      final category3 = Category(
        name: 'Different',
        color: Colors.blue,
        icon: Icons.star_sharp,
      );

      expect(category1 == category2, true);
      expect(category1 == category3, false);
    });

    test('hashCode should be consistent with equality operator', () {
      final category1 = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      final category2 = Category(
        name: 'Test',
        color: Colors.red,
        icon: Icons.stars,
      );

      expect(category1.hashCode, equals(category2.hashCode));
    });
  });
}
