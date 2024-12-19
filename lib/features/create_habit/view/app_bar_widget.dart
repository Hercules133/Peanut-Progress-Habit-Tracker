import 'package:flutter/material.dart';
import '/features/create_habit/view/delete_button_widget.dart';
import '/features/create_habit/view/close_button_widget.dart';
import '/data/models/habit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.appBar, required this.habit});
  final AppBar appBar;
  final Habit habit;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: CloseButtonWidget(
          habit: habit,
        ),
        actions: const <Widget>[
          DeleteButtonWidget(),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
