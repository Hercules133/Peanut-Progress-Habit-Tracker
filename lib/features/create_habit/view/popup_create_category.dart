import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:streaks/data/models/category.dart';
import 'package:streaks/data/providers/category_provider.dart';

Future<void> popupCreateCategory(BuildContext context) async {
  IconData _selectedIcon = Icons.star;
  Color _selectedColor = Colors.red; // Shared variable for the color
  final TextEditingController _textController = TextEditingController();
  final categoryProvider= Provider.of<CategoryProvider> (context, listen: false); 
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
                  value: _selectedIcon,
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
                        _selectedIcon = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final pickedColor =
                        await _pickColor(context, _selectedColor);
                    if (pickedColor != null) {
                      setState(() {
                        _selectedColor = pickedColor;
                      });
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: _selectedColor,
                    radius: 15,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textController,
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
                      Category cat= Category(name: _textController.text , color: _selectedColor, icon: _selectedIcon); 
                      debugPrint(_textController.text);
                      debugPrint(_selectedColor.toString()); 
                      debugPrint(_selectedIcon.toString()); 
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
    },
  );
}

Future<Color?> _pickColor(BuildContext context, Color initialColor) async {
  Color tempColor = initialColor;
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select color"),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: initialColor,
            onColorChanged: (Color color) {
              tempColor = color;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(tempColor),
            child: const Text("Ok"),
          ),
        ],
      );
    },
  );
}
