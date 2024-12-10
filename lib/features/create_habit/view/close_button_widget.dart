import 'package:flutter/material.dart';
import 'package:streaks/features/create_habit/view/popup_saving_widget.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await popupSavingWidget(context);
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      icon: const Icon(Icons.close),
    );
  }
}
