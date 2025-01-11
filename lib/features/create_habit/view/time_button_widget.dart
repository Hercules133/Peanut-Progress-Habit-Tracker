import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/own_colors.dart';

class TimeButtonWidget extends StatelessWidget {
  TimeButtonWidget({super.key, required this.time, required this.onChanged});

  final ValueNotifier<TimeOfDay> selectedTime =
      ValueNotifier<TimeOfDay>(TimeOfDay.now());
  final TimeOfDay time;
  final Function(TimeOfDay) onChanged;

  @override
  Widget build(BuildContext context) {
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    selectedTime.value = time;
    return ValueListenableBuilder<TimeOfDay>(
        valueListenable: selectedTime,
        builder: (context, value, child) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ownColors.contribution1,
                  minimumSize: const Size(80, 40),
                  maximumSize: const Size(80, 40)),
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData(
                          timePickerTheme: TimePickerThemeData(
                            entryModeIconColor:
                                Theme.of(context).colorScheme.onSurface,
                            dialTextColor:
                                Theme.of(context).colorScheme.onSurface,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            hourMinuteColor: WidgetStateColor.resolveWith(
                                (states) => states
                                        .contains(WidgetState.selected)
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.primary),
                            dialBackgroundColor:
                                Theme.of(context).colorScheme.primary,
                            hourMinuteTextColor: WidgetStateColor.resolveWith(
                                (states) => states
                                        .contains(WidgetState.selected)
                                    ? ownColors.contribution2
                                    : Theme.of(context).colorScheme.onSurface),
                            dialHandColor: ownColors.contribution2,
                            dayPeriodColor:
                                Theme.of(context).colorScheme.onSurface,
                            helpTextStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          textTheme: TextTheme(
                            bodyMedium: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                          ))),
                      child: child!,
                    );
                  },
                );
                if (picked != null) {
                  selectedTime.value = picked;
                  onChanged(picked);
                }
              },
              child: Text(
                value.minute < 10
                    ? '${value.hour}:0${value.minute}'
                    : '${value.hour}:${value.minute}',
                style: const TextStyle(fontSize: 12),
              ));
        });
  }
}
