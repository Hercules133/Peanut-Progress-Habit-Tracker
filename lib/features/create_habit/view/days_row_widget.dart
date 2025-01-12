import 'package:flutter/material.dart';
import '/features/create_habit/view/day_button_widget.dart';
import '/features/create_habit/view/time_button_widget.dart';

class DaysRowWidget extends StatelessWidget {
  const DaysRowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Text("Days "),
              Expanded(
                child: SizedBox(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text("Time"),
              const SizedBox(width: 10),
              TimeButtonWidget(),
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
                          DayButtonWidget(day: "Mo"),
                          DayButtonWidget(day: "Tu"),
                          DayButtonWidget(day: "We"),
                          DayButtonWidget(day: "Th"),
                          DayButtonWidget(day: "Fr"),
                          DayButtonWidget(day: "Sa"),
                          DayButtonWidget(day: "Su"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text("Time"),
              const SizedBox(height: 10),
              TimeButtonWidget(),
            ],
          );
        }
      },
    );
  }
}
