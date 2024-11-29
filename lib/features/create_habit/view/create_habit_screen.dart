import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/providers/habit_provider.dart';
import 'package:streaks/features/create_habit/view/app_bar_widget.dart';
import 'package:streaks/features/create_habit/view/create_habit_form_widget.dart';

class CreateHabit extends StatelessWidget {
  const CreateHabit({super.key});
  

  @override
  Widget build(BuildContext context) {
    // var model = locator.get<HabitProvider>;
    //  List<Map<String, dynamic>> habit= locator.get(); 
    var model= context.watch<HabitProvider>(); 
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
      ),
      body: Consumer<HabitProvider>(builder: (context, habitProvider, child) {
        return CreateHabitFormWidget(); 
      }),
    );
  }
}
