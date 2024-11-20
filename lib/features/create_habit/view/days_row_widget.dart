import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/day_button_widget.dart';
import 'package:streaks/features/create_habit/view/time_button_widget.dart';

class DaysRowWidget extends StatelessWidget {
  const DaysRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const DayButtonWidget(day: "Mo"),
        const DayButtonWidget(day: "Tu"),
        const DayButtonWidget(day: "We"),
        const DayButtonWidget(day: "Th"),
        const DayButtonWidget(day: "Fr"),
        const DayButtonWidget(day: "Sa"),
        const DayButtonWidget(day: "Su"),
        const SizedBox(width: 40),
        TimeButtonWidget(),
      ],
    );
  }
}
