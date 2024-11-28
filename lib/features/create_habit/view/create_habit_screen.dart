import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/core/config/locator.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';
import 'package:streaks/features/create_habit/view/app_bar_widget.dart';
import 'package:streaks/features/create_habit/view/create_habit_form_widget.dart';
import 'package:streaks/data/models/habit.dart';

class CreateHabit extends StatelessWidget {
  const CreateHabit({super.key});
  
 


  @override
  Widget build(BuildContext context) {
    // var model = locator.get<HabitProvider>;
    //  List<Map<String, dynamic>> habit= locator.get(); 
    var model= context.watch<HabitProvider>(); 

    Habit test_habit = Habit(
      title: "Lunch",
      description: "Cook and eat lunch",
      days: [0, 1, 4],
      time: const TimeOfDay(hour: 12, minute: 30),
      category: Category(name: 'Eating', color: '#ec664a', icon: const Icon(Icons.adobe)));

     void updateHabit(Habit h){
      test_habit=h; 
    }
    return InheritedWidgetCreateHabit(
      habit: test_habit, 
      child: Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        // habit: habit,
      ),
      body:  Consumer<HabitProvider>(builder: (context, habitProvider, child) {
        return CreateHabitFormWidget(onHabitChanged: updateHabit,); 
      }),
    )
      
  );
    
  }
}
