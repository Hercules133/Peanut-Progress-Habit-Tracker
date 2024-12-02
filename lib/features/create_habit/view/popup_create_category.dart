import 'package:flutter/material.dart';
import 'package:streaks/core/utils/appcolors.dart';

Future<void> popupCreateCategory(BuildContext context) async {
  IconData selectedIcon = Icons.star;
  int selectedColorIndex = 0;
  final TextEditingController textController = TextEditingController();
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text(
              'Create category',
              style: TextStyle(fontSize: 25),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<IconData>(
                  value: selectedIcon,
                  items: const [
                    DropdownMenuItem(
                      value: Icons.star,
                      child: Icon(Icons.star),
                    ),
                    DropdownMenuItem(
                      value: Icons.favorite,
                      child: Icon(Icons.favorite),
                    ),
                    DropdownMenuItem(
                      value: Icons.home,
                      child: Icon(Icons.home),
                    ),
                  ],
                  onChanged: (IconData? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedIcon = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedIndex =
                        await _pickColorIndex(context, selectedColorIndex);
                    if (pickedIndex != null) {
                      setState(() {
                        selectedColorIndex = pickedIndex;
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        AppColors.getColor(selectedColorIndex, isDarkMode),
                    radius: 15,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
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
                      Navigator.of(context).pop(
                        {
                          'icon': selectedIcon,
                          'name': textController.text,
                          'colorIndex': selectedColorIndex,
                        },
                      );
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ],
          );
        },
      );
    },
  ).then((value) {
    if (value != null) {
      return value;
    } else {
      return {};
    }
  });
}

Future<int?> _pickColorIndex(BuildContext context, int initialIndex) async {
  int tempIndex = initialIndex;
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select color"),
        content: SingleChildScrollView(
          child: Column(
            children: List.generate(AppColors.lightModeColors.length, (index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.getColor(
                      index, Theme.of(context).brightness == Brightness.dark),
                ),
                title: Text('Color $index'),
                onTap: () {
                  tempIndex = index;
                  Navigator.of(context).pop(tempIndex);
                },
              );
            }),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
