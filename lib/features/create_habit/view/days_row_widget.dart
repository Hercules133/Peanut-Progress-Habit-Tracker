import 'package:flutter/material.dart';
import 'package:peanutprogress/core/utils/enums/day_of_week.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/features/create_habit/view/day_button_widget.dart';
import 'package:peanutprogress/features/create_habit/view/time_button_widget.dart';

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
              Text("Days "),
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
                                day: "Mo",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "Tu",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "We",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "Th",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "Fr",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "Sa",
                                days: days,
                                onChanged: () {
                                  habit.value.days = days.value;
                                }),
                            DayButtonWidget(
                                day: "Su",
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
              Text("Time"),
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
                Text("Days"),
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
                Text("Time"),
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
