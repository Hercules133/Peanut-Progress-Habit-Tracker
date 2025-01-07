import 'package:flutter/material.dart';
import '/features/create_habit/view/popup_create_category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
