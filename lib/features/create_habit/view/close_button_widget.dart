import 'package:flutter/material.dart';
// import '/features/create_habit/view/popup_saving_widget.dart';
// import '/core/widgets/details_dialog_widget.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //   ValueNotifier<bool> showDaysError= InheritedWidgetCreateHabit.of(context).showDaysError;
    //  ValueNotifier<bool> pressed= InheritedWidgetCreateHabit.of(context).pressed;

    return IconButton(
      onPressed: () async {
        Navigator.pop(context);
        // final result = await popupSavingWidget(context);

        // if (context.mounted) {
        //   Navigator.pop(context);
        //   if (result != true) {
        //     Navigator.pop(context);
        //     if (result != null) {
        //     showDialog(
        //     context: context,
        //     builder: (context) => HabitDetailsDialog(habit: result),
        //     );
        //     }
        //   }
        // }
      },
      icon: const Icon(Icons.close),
    );
  }
}
