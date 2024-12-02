import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';
import 'package:streaks/data/models/ownColors.dart';

class DayButtonWidget extends StatelessWidget {
  DayButtonWidget({super.key, required this.day});

  final String day;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final ownColors = Theme.of(context).extension<OwnColors>()!;

    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: _hasBeenPressed.value
                  ? ownColors.contribution2
                  : ownColors.contribution1,
              // fixedSize: const Size(10,10),
              maximumSize: const Size(40,40),
              minimumSize: const Size(40,40),
            ),
            onPressed: () {
              _hasBeenPressed.value = !_hasBeenPressed.value;
              if(_hasBeenPressed.value){
                switch(day){
                case "Mo": 
                case "Tu":
                case "We": 
                case "Th":
                case "Fr":
                case "Sa":
                case "Su": 
                }
              }
              else{
                switch(day){
                case "Mo": 
                case "Tu":
                case "We": 
                case "Th":
                case "Fr":
                case "Sa":
                case "Su": 
              }
              }
              
              
              },
            child: Text(day, style: const TextStyle(fontSize: 10),),
          );
        });
  }
}
