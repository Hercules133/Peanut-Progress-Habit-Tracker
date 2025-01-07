import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/providers/habit_provider.dart';
import '/data/providers/category_provider.dart';
// import '/features/create_habit/view/popup_saving_widget.dart';
// import '/core/widgets/details_dialog_widget.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //   ValueNotifier<bool> showDaysError= InheritedWidgetCreateHabit.of(context).showDaysError;
    //  ValueNotifier<bool> pressed= InheritedWidgetCreateHabit.of(context).pressed;

    return IconButton(
      onPressed: () async {
        final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
        final habitProvider = Provider.of<HabitProvider>(context, listen: false);
        final categoriesToRemove = categoryProvider.categories.where((category) {
          final habitsForCategory = habitProvider.getHabitsByCategory(category);
          return habitsForCategory.isEmpty && category.name != 'All';
        }).toList();

        for (final category in categoriesToRemove) {
          categoryProvider.removeCategory(category);
        }
        Navigator.pop(context);
        // final result = await popupSavingWidget(context);

        // if (context.mounted) {
        //   Navigator.pop(context);
        //   if (result != true) {
        //     Navigator.pop(context);
        //     if (result != null) {
        //     showDialog(
        //     context: context,
        //     builder: (context) => HabitDetailsDialog(habit: result),
        //     );
        //     }
        //   }
        // }
      },
      icon: const Icon(Icons.close),
    );
  }
}
