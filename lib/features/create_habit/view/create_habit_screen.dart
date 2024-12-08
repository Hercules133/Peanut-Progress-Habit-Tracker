import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/features/create_habit/view/app_bar_widget.dart';
import 'package:streaks/features/create_habit/view/create_habit_form_widget.dart';
import 'package:streaks/data/models/habit.dart';

class CreateHabit extends StatelessWidget {
   const CreateHabit({
    super.key,
    this.habit,
  });
  
  final Habit? habit; 
  
  @override
  Widget build(BuildContext context) {
      Habit currentHabit = habit ?? Habit.defaultHabit();

    return InheritedWidgetCreateHabit(
      habit: currentHabit, 
      child: Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
      ),
      body:  Consumer<HabitProvider>(builder: (context, habitProvider, child) {
        return CreateHabitFormWidget();
      }),
    )
      
  );
    
  }
}
