import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';

class ProviderCreateHabit extends ChangeNotifier {
  ProviderCreateHabit(
      // {
      // super.key,
      // required this.habit,
      // required this.showDaysError,
      // required this.pressed,
      // required super.child
      // }
      );

  Habit mHabit = Habit.defaultHabit();

  Habit get h => mHabit;

  void setHabit(Habit habit) {
    mHabit = habit;
    notifyListeners();
  }
  // final ValueNotifier<bool> showDaysError;
  //  final bool showDaysError;
  // final ValueNotifier<bool> pressed;
  // final bool pressed;

  // static InheritedWidgetCreateHabit? maybeOf(BuildContext context) {
  //   return context
  //       .dependOnInheritedWidgetOfExactType<InheritedWidgetCreateHabit>();
  // }

  // static InheritedWidgetCreateHabit of(BuildContext context) {
  //   final InheritedWidgetCreateHabit? result = maybeOf(context);
  //   assert(result != null, 'No InheritedWidgetCreateHabit found in context');
  //   return result!;
  // }

  // @override
  // bool updateShouldNotify(InheritedWidgetCreateHabit oldWidget) {
  //   bool result = false;
  //   if (habit != oldWidget.habit) {
  //     result = true;
  //   }
  //   // else if(showDaysError!= oldWidget.showDaysError){
  //   //   result= true;
  //   // }
  //   // else if(pressed!= oldWidget.pressed){
  //   //   result=true;
  //   // }
  //   return result;
  // }
}
