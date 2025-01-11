import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/own_colors.dart';

class DayButtonWidget extends StatelessWidget {
  DayButtonWidget(
      {super.key,
      required this.day,
      required this.days,
      required this.onChanged});

  final String day;
  final ValueNotifier<bool> hasBeenPressed = ValueNotifier<bool>(false);
  final ValueNotifier<List<DayOfWeek>> days;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    for (DayOfWeek d in days.value) {
      switch (day) {
        case "Mo":
          {
            if (d == DayOfWeek.monday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "Tu":
          {
            if (d == DayOfWeek.tuesday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "We":
          {
            if (d == DayOfWeek.wednesday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "Th":
          {
            if (d == DayOfWeek.thursday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "Fr":
          {
            if (d == DayOfWeek.friday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "Sa":
          {
            if (d == DayOfWeek.saturday) {
              hasBeenPressed.value = true;
            }
          }
          break;
        case "Su":
          {
            if (d == DayOfWeek.sunday) {
              hasBeenPressed.value = true;
            }
          }
          break;
      }
    }

    return ValueListenableBuilder<bool>(
        valueListenable: hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: hasBeenPressed.value
                  ? ownColors.contribution2
                  : ownColors.contribution1,
              maximumSize: const Size(40, 40),
              minimumSize: const Size(40, 40),
            ),
            onPressed: () {
              hasBeenPressed.value = !hasBeenPressed.value;
              if (hasBeenPressed.value) {
                switch (day) {
                  case "Mo":
                    days.value.add(DayOfWeek.monday);
                    break;
                  case "Tu":
                    days.value.add(DayOfWeek.tuesday);
                    break;
                  case "We":
                    days.value.add(DayOfWeek.wednesday);
                    break;
                  case "Th":
                    days.value.add(DayOfWeek.thursday);
                    break;
                  case "Fr":
                    days.value.add(DayOfWeek.friday);
                    break;
                  case "Sa":
                    days.value.add(DayOfWeek.saturday);
                    break;
                  case "Su":
                    days.value.add(DayOfWeek.sunday);
                    break;
                }
              } else {
                switch (day) {
                  case "Mo":
                    days.value.remove(DayOfWeek.monday);
                    break;
                  case "Tu":
                    days.value.remove(DayOfWeek.tuesday);
                    break;
                  case "We":
                    days.value.remove(DayOfWeek.wednesday);
                    break;
                  case "Th":
                    days.value.remove(DayOfWeek.thursday);
                    break;
                  case "Fr":
                    days.value.remove(DayOfWeek.friday);
                    break;
                  case "Sa":
                    days.value.remove(DayOfWeek.saturday);
                    break;
                  case "Su":
                    days.value.remove(DayOfWeek.sunday);
                    break;
                }
              }
              onChanged();
            },
            child: Text(
              day,
              style: const TextStyle(fontSize: 10),
            ),
          );
        });
  }
}
