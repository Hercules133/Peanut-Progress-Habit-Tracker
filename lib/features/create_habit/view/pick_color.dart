import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:peanutprogress/data/models/own_colors.dart';

Future<Color?> pickColor(BuildContext context, Color initialColor) async {
  Color tempColor = initialColor;
  final ownColors = Theme.of(context).extension<OwnColors>()!;
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select color"),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 150,
            width: 350,
            child: BlockPicker(
              availableColors: [
                ownColors.category1,
                ownColors.category2,
                ownColors.category3,
                ownColors.category7,
                ownColors.category8,
                ownColors.category9,
                ownColors.category10,
                ownColors.category6,
                ownColors.category5,
                ownColors.category4,
              ],
              pickerColor: initialColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
            ),
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
