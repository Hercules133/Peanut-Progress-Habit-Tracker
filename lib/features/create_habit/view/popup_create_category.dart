import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/category_provider.dart';
import 'package:streaks/data/models/own_colors.dart';
import 'package:streaks/features/create_habit/view/icon_dropdown.dart';
import 'package:streaks/features/create_habit/view/pick_color.dart';

Future<void> popupCreateCategory(BuildContext context) async {
  final ownColors = Theme.of(context).extension<OwnColors>()!;
  final ValueNotifier<IconData> selectedIconNotifier =
      ValueNotifier(Icons.star);
  final ValueNotifier<Color> selectedColorNotifier =
      ValueNotifier(ownColors.category1);
  final TextEditingController textController = TextEditingController();
  final categoryProvider =
      Provider.of<CategoryProvider>(context, listen: false);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Create category',
          style: TextStyle(fontSize: 25),
        ),
        content: Row(
          mainAxisSize: MainAxisSize.min,
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
                  return CircleAvatar(
                    backgroundColor: selectedColor,
                    radius: 15,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Category cat = Category(
                      name: textController.text,
                      color: selectedColorNotifier.value,
                      icon: selectedIconNotifier.value);

                  categoryProvider.addCategory(cat);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              )
            ],
          ),
        ],
      );
    },
  );
}
