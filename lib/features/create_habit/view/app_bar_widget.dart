import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/features/create_habit/view/delete_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/close_button_widget.dart';

/// A AppBar widget to close the screen or delete a habit.
///
/// This widget is used in the [CreateHabitScreenWidget] to close the screen or delete a habit.
/// It uses an [AppBar] to show the [CloseButtonWidget] and the [DeleteButtonWidget].
///
/// ### Required parameters:
/// - [appBar] is the [AppBar] object to show.
/// - [newHabit] is a boolean to check if a new habit is created, because you can only delete habits that already exist.
/// - [habit] is the habit object to delete.
///
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
      {super.key,
      required this.appBar,
      required this.newHabit,
      required this.habit});
  final AppBar appBar;
  final bool newHabit;
  final Habit habit;
  @override
  Widget build(BuildContext context) {
    return AppBar(leading: const CloseButtonWidget(), actions: <Widget>[
      if (newHabit == false) DeleteButtonWidget(habit: habit),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
