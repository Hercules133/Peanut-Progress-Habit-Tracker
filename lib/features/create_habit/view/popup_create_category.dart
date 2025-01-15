import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peanutprogress/data/models/category.dart';
import 'package:peanutprogress/data/providers/category_provider.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:peanutprogress/features/create_habit/view/icon_dropdown.dart';
import 'package:peanutprogress/features/create_habit/view/pick_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays a popup dialog to create a new category.
///
/// The [popupCreateCategory] function shows a custom popup dialog to create a new category.
/// It allows the user to select an icon, pick a color, and input the category name. The dialog validates
/// the input and checks for duplicate category names before adding the new category.
///
/// ### Parameters:
/// - [context] is the BuildContext used to show the dialog.
///
/// This popup uses [IconDropdown] for icon selection and [pickColor] for color selection.
/// It relies on [AppLocalizations] for localization.
Future<void> popupCreateCategory(BuildContext context) async {
  final ownColors = Theme.of(context).extension<OwnColors>()!;
  final ValueNotifier<IconData> selectedIconNotifier =
      ValueNotifier(Icons.star);
  final ValueNotifier<Color> selectedColorNotifier =
      ValueNotifier(ownColors.category1);
  final TextEditingController textController = TextEditingController();
  final categoryProvider =
      Provider.of<CategoryProvider>(context, listen: false);
  final formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.popupCreateCategoryTitle,
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        content: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<IconData>(
                valueListenable: selectedIconNotifier,
                builder: (context, selectedIcon, _) {
                  return IconDropdown(
                    selectedIcon: selectedIcon,
                    onIconChanged: (newIcon) {
                      selectedIconNotifier.value = newIcon;
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final pickedColor =
                      await pickColor(context, selectedColorNotifier.value);
                  if (pickedColor != null) {
                    selectedColorNotifier.value = pickedColor;
                  }
                },
                child: ValueListenableBuilder<Color>(
                  valueListenable: selectedColorNotifier,
                  builder: (context, selectedColor, _) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: selectedColor,
                        radius: 15,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  maxLength: 20,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!
                        .popupCreateCategoryNameHintText,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .popupCreateCategoryRequiredError;
                    }
                    if (categoryProvider.categories
                        .any((cat) => cat.name == value)) {
                      return AppLocalizations.of(context)!
                          .popupCreateCategoryAlreadyExistsError;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Category cat = Category(
                      name: textController.text,
                      color: selectedColorNotifier.value,
                      icon: selectedIconNotifier.value,
                    );
                    if (!categoryProvider.doesCategoryExist(cat)) {
                      categoryProvider.addCategory(cat);
                      Navigator.of(context).pop();
                    }
                  }
                },
                icon: const Icon(Icons.check),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
