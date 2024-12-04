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
              maximumSize: const Size(40,40),
              minimumSize: const Size(40,40),
            ),
            onPressed: () {
              _hasBeenPressed.value = !_hasBeenPressed.value;
              if(_hasBeenPressed.value){
                switch(day){
                case "Mo": inheritedData["days"].add("monday"); 
                break; 
                case "Tu": inheritedData["days"].add("tuesday"); 
                break; 
                case "We": inheritedData["days"].add("wednesday"); 
                break; 
                case "Th": inheritedData["days"].add("thursday"); 
                break;  
                case "Fr": inheritedData["days"].add("friday");  
                break; 
                case "Sa": inheritedData["days"].add("saturday"); 
                break; 
                case "Su": inheritedData["days"].add("sunday"); 
                break; 
                }
              }
              else{
                switch(day){
                case "Mo": inheritedData["days"].remove("monday"); 
                case "Tu": inheritedData["days"].remove("tuesday"); 
                case "We": inheritedData["days"].remove("wednesday"); 
                case "Th": inheritedData["days"].remove("thursday"); 
                case "Fr": inheritedData["days"].remove("friday");  
                case "Sa": inheritedData["days"].remove("saturday"); 
                case "Su": inheritedData["days"].remove("sunday"); 
                }
              } 
            },
            child: Text(day, style: const TextStyle(fontSize: 10),),
          );
        });
  }
}
