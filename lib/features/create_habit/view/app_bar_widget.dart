import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/delete_button_widget.dart';
import 'package:streaks/features/create_habit/view/close_button_widget.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart'; 

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppBarWidget({super.key, required this.appBar});
  final AppBar appBar; 
  // final Habit habit; 

  @override
  Widget build(BuildContext context) {
    //  final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    return AppBar(
        leading: const CloseButtonWidget(), 
        actions: const <Widget>[
          DeleteButtonWidget(), 
        ]);
  }

   @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
