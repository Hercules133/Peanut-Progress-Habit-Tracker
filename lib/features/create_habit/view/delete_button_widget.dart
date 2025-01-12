import 'package:flutter/material.dart';
import '/core/utils/routes.dart';
import '/features/create_habit/view/popup_delete_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

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
