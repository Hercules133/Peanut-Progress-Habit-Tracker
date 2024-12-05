import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/inherited_widget_create_habit.dart';
import 'package:streaks/data/models/ownColors.dart';

class TimeButtonWidget extends StatelessWidget {
  TimeButtonWidget({
    super.key
  });

  final ValueNotifier<TimeOfDay> selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    TimeOfDay time= TimeOfDay(
      hour: int.parse(inheritedData['time'].split(':')[0]),
        minute: int.parse(inheritedData['time'].split(':')[1]),);
    selectedTime.value= time; 
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
                  inheritedData["time"]='${picked.hour}:${picked.minute}'; 
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
