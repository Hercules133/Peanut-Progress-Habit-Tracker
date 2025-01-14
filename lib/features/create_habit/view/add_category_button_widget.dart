import 'package:flutter/material.dart';
import 'package:peanutprogress/features/create_habit/view/popup_create_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A button widget to add a category.
///
/// This widget is used in the [CreateHabitFormWidget] to add a category.
/// It uses an [IconButton] to add a category.
/// It calls the [popupCreateCategory] to create a new category.
///
class AddCategoryButtonWidget extends StatelessWidget {
  const AddCategoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      tooltip: AppLocalizations.of(context)!.addCategoryButtonTooltip,
      onPressed: () {
        popupCreateCategory(context);
      },
    );
  }
}
