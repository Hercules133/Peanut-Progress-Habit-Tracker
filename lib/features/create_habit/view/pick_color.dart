import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:peanutprogress/data/models/own_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays a color picker dialog.
///
/// The [pickColor] function shows a custom popup dialog that uses the [BlockPicker]
/// to allow the user to choose a color from a predefined list.
///
/// ### Parameters:
/// - [context] is the BuildContext used to show the dialog.
/// - [initialColor] is the initially selected color displayed in the picker.
///
/// ### Returns:
/// - A [Future] that resolves to the selected [Color] or `null` if no selection is made.
///
/// This function uses [OwnColors] for the available colors and [AppLocalizations] for localization.
Future<Color?> pickColor(BuildContext context, Color initialColor) async {
  Color tempColor = initialColor;
  final ownColors = Theme.of(context).extension<OwnColors>()!;
  return showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.daysRowWidgetSelectColor),
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
          IconButton(
            onPressed: () => Navigator.of(context).pop(tempColor),
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      );
    },
  );
}
