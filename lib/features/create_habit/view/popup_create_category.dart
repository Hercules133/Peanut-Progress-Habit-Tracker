import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<void> popupCreateCategory(BuildContext context) async {
  IconData _selectedIcon = Icons.star;
  Color _selectedColor = Colors.red;
  final TextEditingController _textController = TextEditingController();
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
                // Do something with newValue
              },
            ),
            const SizedBox(width: 10),

            GestureDetector(
              onTap: () async {},
              child: CircleAvatar(
                backgroundColor: _selectedColor,
                radius: 15,
              ),
            ),
            const SizedBox(width: 10),

            // Textfeld
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
                    child: const Text('Cancel')),
              ),
              TextButton(
                onPressed: () {
                  // save new category
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

Future<Color?> _pickColor(BuildContext context) async {
  Color _selectedColor = Colors.red;
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      Color tempColor = _selectedColor;
      return AlertDialog(
        title: const Text("Farbe auswählen"),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _selectedColor,
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
