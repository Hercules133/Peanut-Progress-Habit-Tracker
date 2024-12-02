import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';
import 'package:streaks/features/create_habit/view/app_bar_widget.dart';
import 'package:streaks/features/create_habit/view/create_habit_form_widget.dart';
import 'package:streaks/data/models/habit.dart';

class CreateHabit extends StatelessWidget {
  const CreateHabit({
    super.key,
   // this.habit
  });
  
   //final Habit habit; 
  
  @override
  Widget build(BuildContext context) {

    Habit testHabit = Habit(
      title: "Lunch",
      description: "Cook and eat lunch",
      days: [0, 1, 4],
      time: const TimeOfDay(hour: 12, minute: 30),
      category: Category(name: 'Eating', color: '#ec664a', icon: const Icon(Icons.adobe)));


    return InheritedWidgetCreateHabit(
      habit: testHabit, 
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
