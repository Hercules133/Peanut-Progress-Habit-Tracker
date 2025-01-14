import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/features/create_habit/view/day_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/time_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A row widget to set/change the days and time of a habit.
///
/// This widget is used in the [CreateHabitFormWidget] to set the days and time of a habit.
/// It uses a [ValueNotifier] to update the habit object.
/// The [DaysRowWidget] contains the [DayButtonWidget] and the [TimeButtonWidget].
/// It uses Responsive Design to show the widgets in a row or column depending on the screen width.
///
/// ### Required parameters:
/// - [habit] is the habit object to update.
///
class DaysRowWidget extends StatelessWidget {
  const DaysRowWidget({
    super.key,
    required this.habit,
  });

  final ValueNotifier<Habit> habit;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<DayOfWeek>> days =
        ValueNotifier<List<DayOfWeek>>(habit.value.days);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Text("${AppLocalizations.of(context)!.daysRowWidgetDays} "),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: ValueListenableBuilder(
                      valueListenable: days,
                      builder: (context, value, child) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.monday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.tuesday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.wednesday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.thursday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.friday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.saturday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: AppLocalizations.of(context)!.sunday,
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                          ],
                        );
                      }),
                ),
              ),
              const SizedBox(width: 20),
              Text(AppLocalizations.of(context)!.daysRowWidgetReminder),
              const SizedBox(width: 10),
              TimeButtonWidget(
                  time: habit.value.time,
                  onChanged: (value) {
                    habit.value.time = value;
                  }),
            ],
          );
        } else {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.daysRowWidgetDays),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Mo",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Tu",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "We",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Th",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Fr",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Sa",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                            ValueListenableBuilder(
                                valueListenable: days,
                                builder: (context, value, child) {
                                  return DayButtonWidget(
                                      day: "Su",
                                      days: days,
                                      onChanged: () {
                                        habit.value.days = days.value;
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(AppLocalizations.of(context)!.daysRowWidgetReminder),
                const SizedBox(width: 10),
                TimeButtonWidget(
                    time: habit.value.time,
                    onChanged: (value) {
                      habit.value.time = value;
                    }),
              ]);
        }
      },
    );
  }
}
