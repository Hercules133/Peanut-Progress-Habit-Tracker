import 'package:flutter/material.dart';
import 'package:peanutprogress/data/models/habit.dart';
import 'package:peanutprogress/core/utils/routes.dart';
import 'package:peanutprogress/features/create_habit/view/popup_delete_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A delete button widget to delete a habit.
///
/// This widget is used in the [AppBarWidget] on the [CreateHabitScreenWidget] to delete a habit.
/// It uses an [IconButton] to delete a habit.
/// It calls the [popupDeleteWidget] to confirm the deletion of a habit and navigate to the home screen when the deletion was confirmed.
///
/// ### Required parameters:
/// - [habit] is the habit object to delete.
///
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
