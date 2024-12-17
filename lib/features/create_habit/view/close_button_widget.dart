import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/popup_saving_widget.dart';
import 'package:streaks/core/widgets/details_dialog_widget.dart';

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
        final result = await popupSavingWidget(context);

        if (context.mounted) {
          if (result != true) {
            Navigator.pop(context);
            if (result != null) showDetailsDialog(context, result);
          }
        }
      },
      icon: const Icon(Icons.close),
    );
  }
}
