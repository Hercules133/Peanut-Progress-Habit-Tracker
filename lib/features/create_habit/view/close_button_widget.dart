import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/popup_saving_widget.dart';
import 'package:streaks/features/create_habit/inherited_widget_create_habit.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final inheritedData = InheritedWidgetCreateHabit.of(context).habit;
    return IconButton(
          onPressed: () async {
            await popupSavingWidget(context); 
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ); 
  }
}