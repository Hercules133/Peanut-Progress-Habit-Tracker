import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';



class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider= Provider.of<HabitProvider> (context, listen: false); 
     final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      tooltip: "Delete",
      onPressed: () {
        habitProvider.deleteHabit(inheritedData.id); 
        Navigator.pop(context); 
      },
    );
  }
}
