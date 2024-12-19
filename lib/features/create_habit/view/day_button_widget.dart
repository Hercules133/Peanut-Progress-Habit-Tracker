import 'package:flutter/material.dart';
import '/core/utils/enums/day_of_week.dart';
import '/features/create_habit/view/inherited_widget_create_habit.dart';
import '/data/models/own_colors.dart';

class DayButtonWidget extends StatelessWidget {
  DayButtonWidget({super.key, required this.day});

  final String day;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    final ownColors = Theme.of(context).extension<OwnColors>()!;
    for (DayOfWeek d in inheritedData.days) {
      switch (day) {
        case "Mo":
          {
            if (d == DayOfWeek.monday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "Tu":
          {
            if (d == DayOfWeek.tuesday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "We":
          {
            if (d == DayOfWeek.wednesday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "Th":
          {
            if (d == DayOfWeek.thursday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "Fr":
          {
            if (d == DayOfWeek.friday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "Sa":
          {
            if (d == DayOfWeek.saturday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
        case "Su":
          {
            if (d == DayOfWeek.sunday) {
              _hasBeenPressed.value = true;
            }
          }
          break;
      }
    }

    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: _hasBeenPressed.value
                  ? ownColors.contribution2
                  : ownColors.contribution1,
              maximumSize: const Size(40, 40),
              minimumSize: const Size(40, 40),
            ),
            onPressed: () {
              _hasBeenPressed.value = !_hasBeenPressed.value;
              if (_hasBeenPressed.value) {
                switch (day) {
                  case "Mo":
                    inheritedData.days.add(DayOfWeek.monday);
                    break;
                  case "Tu":
                    inheritedData.days.add(DayOfWeek.tuesday);
                    break;
                  case "We":
                    inheritedData.days.add(DayOfWeek.wednesday);
                    break;
                  case "Th":
                    inheritedData.days.add(DayOfWeek.thursday);
                    break;
                  case "Fr":
                    inheritedData.days.add(DayOfWeek.friday);
                    break;
                  case "Sa":
                    inheritedData.days.add(DayOfWeek.saturday);
                    break;
                  case "Su":
                    inheritedData.days.add(DayOfWeek.sunday);
                    break;
                }
              } else {
                switch (day) {
                  case "Mo":
                    inheritedData.days.remove(DayOfWeek.monday);
                  case "Tu":
                    inheritedData.days.remove(DayOfWeek.tuesday);
                  case "We":
                    inheritedData.days.remove(DayOfWeek.wednesday);
                  case "Th":
                    inheritedData.days.remove(DayOfWeek.thursday);
                  case "Fr":
                    inheritedData.days.remove(DayOfWeek.friday);
                  case "Sa":
                    inheritedData.days.remove(DayOfWeek.saturday);
                  case "Su":
                    inheritedData.days.remove(DayOfWeek.sunday);
                }
              }
            },
            child: Text(
              day,
              style: const TextStyle(fontSize: 10),
            ),
          );
        });
  }
}
