import 'package:flutter/material.dart';

class TimeButtonWidget extends StatelessWidget {
  TimeButtonWidget({
    super.key
  });

  final ValueNotifier<TimeOfDay> selectedTime = ValueNotifier<TimeOfDay>(TimeOfDay.now());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TimeOfDay>(
        valueListenable: selectedTime,
        builder: (context, value, child) {
          return ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                );
                if (picked != null) {
                  selectedTime.value = picked;
                }
              },
              child: Text(
                '${value.hour}:${value.minute}',
                style: const TextStyle(fontSize: 18),
              ));
        });
  }
}
