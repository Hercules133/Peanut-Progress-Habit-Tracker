import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/providers/habit_provider.dart';
import 'package:peanutprogress/features/create_habit/view/app_bar_widget.dart';
import 'package:peanutprogress/features/create_habit/view/create_habit_form_widget.dart';
import 'package:peanutprogress/data/models/habit.dart';

/// A screen widget to create or edit a habit.
///
/// This widget is used to create or edit a habit.
/// It uses the [AppBarWidget] and the [CreateHabitFormWidget] to create or edit a habit.
///
/// ### Required parameters:
/// - [habit] is the habit object to edit or a defaultHabit if the habit is about to be created.
/// - [newHabit] is a boolean to check if a new habit is created, because you can only delete habits that already exist.
///
class CreateHabit extends StatelessWidget {
  const CreateHabit({super.key, this.habit, required this.newHabit});

  final Habit? habit;
  final bool newHabit;

  @override
  Widget build(BuildContext context) {
    Habit currentHabit = habit ?? Habit.defaultHabit();
    Habit h = Habit.from(currentHabit);

    return Scaffold(
      appBar: AppBarWidget(
        appBar: AppBar(),
        newHabit: newHabit,
        habit: h,
      ),
      body: Consumer<HabitProvider>(builder: (context, habitProvider, child) {
        return CreateHabitFormWidget(
          habit: h,
        );
      }),
    );
  }
}
