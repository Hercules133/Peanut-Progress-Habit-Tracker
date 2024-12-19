import 'package:flutter/material.dart';
import '/features/create_habit/view/popup_saving_widget.dart';
import '/core/widgets/details_dialog_widget.dart';
import '/data/models/habit.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key, required this.habit});

  final Habit habit;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await popupSavingWidget(context);
        if (context.mounted) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => HabitDetailsDialog(habit: habit),
          );
        }
      },
      icon: const Icon(Icons.close),
    );
  }
}
