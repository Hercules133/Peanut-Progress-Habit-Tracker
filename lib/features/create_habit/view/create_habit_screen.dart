import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/data/providers/habit_provider.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import '/features/create_habit/view/app_bar_widget.dart';
import '/features/create_habit/view/create_habit_form_widget.dart';
import '/data/models/habit.dart';

class CreateHabit extends StatelessWidget {
  const CreateHabit({super.key, this.habit, required this.newHabit});

  final Habit? habit;
  final bool newHabit;

  @override
  Widget build(BuildContext context) {
    Habit currentHabit = habit ?? Habit.defaultHabit();
    Habit h = Habit.from(currentHabit);
    final provider = Provider.of<ProviderCreateHabit>(context);
    provider.setHabit(h);

    // Empty e = Empty();

    // return Consumer<ProviderCreateHabit>(
    //   builder: (context, provider, child) {
    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        newHabit: newHabit,
      ),
      body: Consumer<HabitProvider>(builder: (context, habitProvider, child) {
        return CreateHabitFormWidget();
      }),
    );
    // )
    // });
  }
}
