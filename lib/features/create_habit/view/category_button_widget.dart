import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  CategoryButtonWidget(
      {super.key, required this.category, required this.color});

  final String category;
  final Color color;
  final ValueNotifier<bool> _hasBeenPressed = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _hasBeenPressed,
        builder: (context, value, child) {
          return TextButton(
              style: ButtonStyle(
                  backgroundColor: _hasBeenPressed.value
                  ? const WidgetStatePropertyAll(Colors.yellow)
                  : WidgetStatePropertyAll<Color>(color),
              ),
              onPressed: () {_hasBeenPressed.value = !_hasBeenPressed.value;},
              child: Text(category));
        });
  }
}
