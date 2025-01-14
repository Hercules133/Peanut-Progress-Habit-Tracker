import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/own_colors.dart';

/// A day button widget to set the days of a habit.
///
/// This widget is used in the [DaysRowWidget] to set the days of a habit.
/// It uses a [ValueNotifier] to update the days of the habit object.
///
/// ### Required parameters:
/// - [day] is the day that belongs to the button.
/// - [days]  is a [ValueNotifier] that contains a List of the selected days of the habit object.
/// - [hasBeenPressed] is a [ValueNotifier] to update the buttons color and the [days] List when the day is selected/not selected.
/// - [onChanged] is a [VoidCallback] function to notify the parent widget of a change in the [days] list.
///
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

    /// Check if the day is already selected and update the button color.
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
              maximumSize: const Size(50, 50),
              minimumSize: const Size(40, 40),
            ),
            onPressed: () {
              /// Update the button color and add/remove the day to/from the days list.
              /// toggle the hasBeenPressed value.
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
