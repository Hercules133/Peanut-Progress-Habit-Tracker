import 'package:flutter/material.dart';
import '/core/utils/routes.dart';
import '/features/create_habit/view/popup_delete_widget.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      tooltip: "Delete",
      onPressed: () async {
        var result = await popupDeleteWidget(context);
        if (result && context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            Routes.home,
          );
        }
      },
    );
  }
}
