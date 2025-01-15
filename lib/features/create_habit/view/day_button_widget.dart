import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    final appLocalizations = AppLocalizations.of(context)!;

    // Map day strings to DayOfWeek enum values
    final dayMap = {
      appLocalizations.monday: DayOfWeek.monday,
      appLocalizations.tuesday: DayOfWeek.tuesday,
      appLocalizations.wednesday: DayOfWeek.wednesday,
      appLocalizations.thursday: DayOfWeek.thursday,
      appLocalizations.friday: DayOfWeek.friday,
      appLocalizations.saturday: DayOfWeek.saturday,
      appLocalizations.sunday: DayOfWeek.sunday,
    };

    final dayOfWeek = dayMap[day];

    /// Check if the day is already selected and update the button color.
    final hasBeenPressed = ValueNotifier<bool>(days.value.contains(dayOfWeek));

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

              hasBeenPressed.value = !value;
              if (hasBeenPressed.value) {
                days.value.add(dayOfWeek!);
              } else {
                days.value.remove(dayOfWeek!);
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
