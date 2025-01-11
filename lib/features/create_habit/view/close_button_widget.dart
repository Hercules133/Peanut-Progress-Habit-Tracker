import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        final habitProvider =
            Provider.of<HabitProvider>(context, listen: false);
        final categoriesToRemove =
            categoryProvider.categories.where((category) {
          final habitsForCategory = habitProvider.getHabitsByCategory(category);
          return habitsForCategory.isEmpty && category.name != 'All';
        }).toList();

        for (final category in categoriesToRemove) {
          categoryProvider.removeCategory(category);
        }
        Navigator.pop(context);
      },
      icon: const Icon(Icons.close),
    );
  }
}
