import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';

class TimeButtonWidget extends StatelessWidget {
  TimeButtonWidget({
    super.key
  });

  final ValueNotifier<TimeOfDay> selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    selectedTime.value= inheritedData.time; 
    return ValueListenableBuilder<TimeOfDay>(
        valueListenable: selectedTime,
        builder: (context, value, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(85,40),
              maximumSize: const Size(85,40)
            ),
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                );
                if (picked != null) {
                  selectedTime.value = picked;
                  inheritedData.time=picked; 
                }
              },
              child: Text(
                value.minute <10
                ? '${value.hour}:0${value.minute}'
                :  '${value.hour}:${value.minute}',
                style: const TextStyle(fontSize: 15),
              ));
        });
  }
}
