import 'package:flutter/material.dart';
import '/features/create_habit/view/day_button_widget.dart';
import '/features/create_habit/view/time_button_widget.dart';

class DaysRowWidget extends StatelessWidget {
  const DaysRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          DayButtonWidget(day: "Mo"),
          DayButtonWidget(day: "Tu"),
          DayButtonWidget(day: "We"),
          DayButtonWidget(day: "Th"),
          DayButtonWidget(day: "Fr"),
          DayButtonWidget(day: "Sa"),
          DayButtonWidget(day: "Su"),
          const SizedBox(width: 20),
          TimeButtonWidget(),
        ],
      ),
    );
  }
}
