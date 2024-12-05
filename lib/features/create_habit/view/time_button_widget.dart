import 'package:flutter/material.dart';
import 'package:streaks/data/models/habit.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/data/models/ownColors.dart';

class TimeButtonWidget extends StatelessWidget {
  TimeButtonWidget({
    super.key
  });

  final ValueNotifier<TimeOfDay> selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  @override
  Widget build(BuildContext context) {
    Habit inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    selectedTime.value= inheritedData.time; 
    return ValueListenableBuilder<TimeOfDay>(
        valueListenable: selectedTime,
        builder: (context, value, child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ownColors.contribution1,
              minimumSize: const Size(80,40),
              maximumSize: const Size(80,40)
            ),
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                );
                if (picked != null) {
                  selectedTime.value = picked;
                  inheritedData= inheritedData.copyWith(time: picked); 
                }
              },
              child: Text(
                value.minute <10
                ? '${value.hour}:0${value.minute}'
                : '${value.hour}:${value.minute}',
                style: const TextStyle(fontSize: 12),
              ));
        });
  }
}
