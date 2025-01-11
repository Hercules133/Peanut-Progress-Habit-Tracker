import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/features/create_habit/view/popup_delete_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      tooltip: AppLocalizations.of(context)!.deleteButtonTooltip,
      onPressed: () async {
        FocusScope.of(context).unfocus();
        var result = await popupDeleteWidget(context, habit);
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
