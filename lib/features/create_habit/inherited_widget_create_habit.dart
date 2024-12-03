import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';

class InheritedWidgetCreateHabit extends InheritedWidget {

  const InheritedWidgetCreateHabit({
    super.key,
    required this.habit,
    required super.child});

    final Map<String, dynamic> habit; 
  
  static InheritedWidgetCreateHabit? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedWidgetCreateHabit>();
  }

  static InheritedWidgetCreateHabit of(BuildContext context) {
    final InheritedWidgetCreateHabit? result = maybeOf(context);
    assert(result != null, 'No InheritedWidgetCreateHabit found in context');
    return result!;
  }
@override
  bool updateShouldNotify(InheritedWidgetCreateHabit oldWidget) => habit != oldWidget.habit; 

}